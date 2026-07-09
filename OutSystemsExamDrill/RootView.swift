import SwiftUI

struct RootView: View {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var connectivity = NetworkStatusMonitor()
    @StateObject private var adCoordinator = AdCoordinator()

    var body: some View {
        Group {
            if let screenshotTarget = ScreenshotTarget.current {
                ScreenshotPreviewView(target: screenshotTarget)
            } else if connectivity.isOnline {
                VStack(spacing: 0) {
                    mainTabs
                    AdBannerSlot(isOnline: connectivity.isOnline)
                }
                .background(Color.drillShell)
            } else {
                OfflineRequiredView(statusText: connectivity.statusText)
            }
        }
        .environmentObject(connectivity)
        .environmentObject(adCoordinator)
        .onAppear {
            guard ScreenshotTarget.current == nil else { return }
            adCoordinator.configureIfNeeded(isOnline: connectivity.isOnline)
            adCoordinator.handleInitialActivation(isOnline: connectivity.isOnline)
        }
        .onChange(of: connectivity.isOnline) { isOnline in
            guard ScreenshotTarget.current == nil else { return }
            guard isOnline else { return }
            adCoordinator.configureIfNeeded(isOnline: true)
            adCoordinator.handleInitialActivation(isOnline: true)
        }
        .onChange(of: scenePhase) { newPhase in
            guard ScreenshotTarget.current == nil else { return }
            adCoordinator.handleScenePhaseChange(newPhase, isOnline: connectivity.isOnline)
        }
    }

    private var mainTabs: some View {
        TabView {
            HomeFlowView()
                .tabItem {
                    Label("ホーム", systemImage: "house.fill")
                }

            LearningView()
                .tabItem {
                    Label("教材", systemImage: "book.closed.fill")
                }

            StatsView()
                .tabItem {
                    Label("成績", systemImage: "chart.bar.xaxis")
                }
        }
        .tint(Color.drillBrand)
    }
}

private struct HomeFlowView: View {
    @EnvironmentObject private var store: DrillStore
    @EnvironmentObject private var connectivity: NetworkStatusMonitor
    @EnvironmentObject private var adCoordinator: AdCoordinator
    @State private var selectedExam: ExamDefinition?
    @State private var quizConfig: QuizConfig?
    @State private var result: QuizResult?

    var body: some View {
        ZStack {
            Color.drillBackground.ignoresSafeArea()

            if let result {
                ResultView(
                    result: result,
                    onReviewWrong: {
                        startReview(from: result)
                    },
                    onHome: {
                        self.result = nil
                        selectedExam = nil
                    }
                )
            } else if let quizConfig {
                QuizView(
                    config: quizConfig,
                    onQuit: {
                        self.quizConfig = nil
                    },
                    onFinish: { finishedResult in
                        self.quizConfig = nil
                        result = finishedResult
                        adCoordinator.showInterstitialAfterQuizIfEligible(isOnline: connectivity.isOnline)
                    }
                )
            } else if let selectedExam {
                ModeView(
                    exam: selectedExam,
                    onBack: {
                        self.selectedExam = nil
                    },
                    onStart: { mode, domains in
                        start(mode: mode, domains: domains, exam: selectedExam)
                    }
                )
            } else {
                HomeView { exam in
                    selectedExam = exam
                }
            }
        }
    }

    private func start(mode: QuizMode, domains: Set<Int>, exam: ExamDefinition) {
        let pool: [DrillQuestion]

        switch mode {
        case .practice:
            pool = exam.questions.filter { domains.contains($0.domain) }
        case .mock:
            pool = exam.mockMix
                .sorted { $0.key < $1.key }
                .flatMap { entry in
                    Array(exam.questions.filter { $0.domain == entry.key }.shuffled().prefix(entry.value))
                }
        case .wrong:
            let ids = store.wrongIDs(for: exam.id)
            pool = exam.questions.filter { ids.contains($0.id) }
        case .bookmark:
            let ids = store.bookmarkIDs(for: exam.id)
            pool = exam.questions.filter { ids.contains($0.id) }
        case .review:
            pool = []
        }

        guard !pool.isEmpty else { return }
        quizConfig = QuizConfig(
            exam: exam,
            mode: mode,
            items: makeItems(from: pool),
            durationSeconds: mode == .mock ? exam.mockMinutes * 60 : nil
        )
    }

    private func startReview(from result: QuizResult) {
        let questions = result.wrongQuestionIDs.compactMap { result.exam.question(withID: $0) }
        guard !questions.isEmpty else { return }
        self.result = nil
        selectedExam = result.exam
        quizConfig = QuizConfig(
            exam: result.exam,
            mode: .review,
            items: makeItems(from: questions),
            durationSeconds: nil
        )
    }

    private func makeItems(from questions: [DrillQuestion]) -> [QuizItem] {
        questions
            .shuffled()
            .map { question in
                QuizItem(question: question, optionOrder: Array(question.options.indices).shuffled())
            }
    }
}
