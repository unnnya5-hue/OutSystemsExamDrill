import SwiftUI
import UIKit

#if canImport(GoogleMobileAds)
import GoogleMobileAds
#endif

enum AdConfiguration {
    static let appID = "ca-app-pub-6961277874965643~4120849032"
    static let appOpenUnitID = "ca-app-pub-6961277874965643/1714177546"
    static let bannerUnitID = "ca-app-pub-6961277874965643/1686292775"
    static let interstitialUnitID = "ca-app-pub-6961277874965643/7706694657"
    static let minimumFullScreenAdInterval: TimeInterval = 75
    static let minimumBackgroundDurationForAppOpen: TimeInterval = 5 * 60
    static let quizInterstitialFrequency = 1
    static let learningInterstitialFrequency = 3
}

@MainActor
final class AdCoordinator: NSObject, ObservableObject {
    private var isConfigured = false
    private let launchTime = Date()
    private var didRequestInitialAppOpenAd = false
    private var lastFullScreenAdShownAt: Date?
    private var backgroundedAt: Date?
    private var completedQuizCount = 0
    private var completedLearningDetailCount = 0

    #if canImport(GoogleMobileAds)
    private var appOpenAd: AppOpenAd?
    private var appOpenAdLoadTime: Date?
    private var isLoadingAppOpenAd = false
    private var isShowingAppOpenAd = false

    private var interstitialAd: InterstitialAd?
    private var isLoadingInterstitial = false
    #endif

    func configureIfNeeded(isOnline: Bool) {
        guard isOnline else { return }

        #if canImport(GoogleMobileAds)
        guard !isConfigured else { return }
        isConfigured = true
        MobileAds.shared.start()
        preloadAds()
        #endif
    }

    func preloadAds() {
        #if canImport(GoogleMobileAds)
        Task {
            await loadAppOpenAd()
            await loadInterstitial()
        }
        #endif
    }

    func handleInitialActivation(isOnline: Bool) {
        guard isOnline, !didRequestInitialAppOpenAd else { return }
        didRequestInitialAppOpenAd = true
        showAppOpenAdIfAvailable(isOnline: isOnline)
    }

    func handleScenePhaseChange(_ scenePhase: ScenePhase, isOnline: Bool) {
        switch scenePhase {
        case .background:
            backgroundedAt = Date()
        case .active:
            configureIfNeeded(isOnline: isOnline)

            guard didRequestInitialAppOpenAd else {
                handleInitialActivation(isOnline: isOnline)
                return
            }

            guard let backgroundedAt else { return }
            let backgroundDuration = Date().timeIntervalSince(backgroundedAt)
            self.backgroundedAt = nil

            guard backgroundDuration >= AdConfiguration.minimumBackgroundDurationForAppOpen else { return }
            showAppOpenAdIfAvailable(isOnline: isOnline)
        default:
            break
        }
    }

    func showInterstitialAfterQuizIfEligible(isOnline: Bool) {
        completedQuizCount += 1
        guard completedQuizCount.isMultiple(of: AdConfiguration.quizInterstitialFrequency) else {
            preloadInterstitialIfNeeded()
            return
        }
        showInterstitialIfAvailable(isOnline: isOnline)
    }

    func showInterstitialAfterLearningDetailIfEligible(isOnline: Bool) {
        completedLearningDetailCount += 1
        guard completedLearningDetailCount.isMultiple(of: AdConfiguration.learningInterstitialFrequency) else {
            preloadInterstitialIfNeeded()
            return
        }
        showInterstitialIfAvailable(isOnline: isOnline)
    }

    private func showAppOpenAdIfAvailable(isOnline: Bool) {
        guard isOnline else { return }

        #if canImport(GoogleMobileAds)
        configureIfNeeded(isOnline: isOnline)

        guard !isShowingAppOpenAd else { return }
        guard canShowFullScreenAdNow else {
            Task { await loadAppOpenAd() }
            return
        }

        if let appOpenAd, isAppOpenAdFresh {
            presentAppOpenAd(appOpenAd)
        } else {
            Task {
                await loadAppOpenAd(presentWhenLoaded: true)
            }
        }
        #endif
    }

    private func showInterstitialIfAvailable(isOnline: Bool) {
        guard isOnline else { return }

        #if canImport(GoogleMobileAds)
        configureIfNeeded(isOnline: isOnline)
        guard !isShowingAppOpenAd else { return }
        guard canShowInterstitialNow else {
            Task { await loadInterstitial() }
            return
        }

        if let interstitialAd {
            self.interstitialAd = nil
            markFullScreenAdShown()
            interstitialAd.present(from: rootViewController)
        } else {
            Task {
                await loadInterstitial()
            }
        }
        #endif
    }

    private var canShowFullScreenAdNow: Bool {
        guard let lastFullScreenAdShownAt else { return true }
        return Date().timeIntervalSince(lastFullScreenAdShownAt) >= AdConfiguration.minimumFullScreenAdInterval
    }

    private var canShowInterstitialNow: Bool {
        Date().timeIntervalSince(launchTime) >= AdConfiguration.minimumFullScreenAdInterval
            && canShowFullScreenAdNow
    }

    private func markFullScreenAdShown() {
        lastFullScreenAdShownAt = Date()
    }

    private func preloadInterstitialIfNeeded() {
        #if canImport(GoogleMobileAds)
        Task { await loadInterstitial() }
        #endif
    }

    #if canImport(GoogleMobileAds)
    private var isAppOpenAdFresh: Bool {
        guard let appOpenAdLoadTime else { return false }
        return Date().timeIntervalSince(appOpenAdLoadTime) < 4 * 60 * 60
    }

    private var rootViewController: UIViewController? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .first { $0.isKeyWindow }?
            .rootViewController
    }

    private func loadAppOpenAd(presentWhenLoaded: Bool = false) async {
        guard !isLoadingAppOpenAd else { return }
        guard appOpenAd == nil || !isAppOpenAdFresh else {
            if presentWhenLoaded, let appOpenAd {
                presentAppOpenAd(appOpenAd)
            }
            return
        }

        isLoadingAppOpenAd = true
        do {
            let ad = try await AppOpenAd.load(
                with: AdConfiguration.appOpenUnitID,
                request: Request()
            )
            ad.fullScreenContentDelegate = self
            appOpenAd = ad
            appOpenAdLoadTime = Date()
            isLoadingAppOpenAd = false

            if presentWhenLoaded {
                presentAppOpenAd(ad)
            }
        } catch {
            appOpenAd = nil
            appOpenAdLoadTime = nil
            isLoadingAppOpenAd = false
        }
    }

    private func loadInterstitial() async {
        guard interstitialAd == nil, !isLoadingInterstitial else { return }

        isLoadingInterstitial = true
        do {
            let ad = try await InterstitialAd.load(
                with: AdConfiguration.interstitialUnitID,
                request: Request()
            )
            ad.fullScreenContentDelegate = self
            interstitialAd = ad
        } catch {
            interstitialAd = nil
        }
        isLoadingInterstitial = false
    }

    private func presentAppOpenAd(_ ad: AppOpenAd) {
        guard !isShowingAppOpenAd else { return }
        isShowingAppOpenAd = true
        appOpenAd = nil
        markFullScreenAdShown()
        ad.present(from: rootViewController)
    }
    #endif
}

#if canImport(GoogleMobileAds)
extension AdCoordinator: FullScreenContentDelegate {
    func ad(
        _ ad: FullScreenPresentingAd,
        didFailToPresentFullScreenContentWithError error: Error
    ) {
        if isShowingAppOpenAd {
            self.appOpenAd = nil
            appOpenAdLoadTime = nil
            isShowingAppOpenAd = false
            Task { await loadAppOpenAd() }
        } else {
            interstitialAd = nil
            Task { await loadInterstitial() }
        }
    }

    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        if isShowingAppOpenAd {
            isShowingAppOpenAd = false
            appOpenAd = nil
            appOpenAdLoadTime = nil
            Task { await loadAppOpenAd() }
        } else {
            interstitialAd = nil
            Task { await loadInterstitial() }
        }
    }
}
#endif

struct AdBannerSlot: View {
    let isOnline: Bool

    var body: some View {
        Group {
            if isOnline {
                #if canImport(GoogleMobileAds)
                GoogleMobileBannerView(adUnitID: AdConfiguration.bannerUnitID)
                    .frame(width: 320, height: 50)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
                    .background(Color.drillShell)
                    .accessibilityLabel("広告")
                #else
                EmptyView()
                #endif
            }
        }
    }
}

#if canImport(GoogleMobileAds)
private struct GoogleMobileBannerView: UIViewRepresentable {
    let adUnitID: String

    func makeUIView(context: Context) -> BannerView {
        let bannerView = BannerView(adSize: AdSizeBanner)
        bannerView.adUnitID = adUnitID
        bannerView.rootViewController = rootViewController
        bannerView.load(Request())
        return bannerView
    }

    func updateUIView(_ uiView: BannerView, context: Context) {
        uiView.rootViewController = rootViewController
    }

    private var rootViewController: UIViewController? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .first { $0.isKeyWindow }?
            .rootViewController
    }
}
#endif
