import Network
import SwiftUI

@MainActor
final class NetworkStatusMonitor: ObservableObject {
    @Published private(set) var isOnline = false
    @Published private(set) var statusText = "接続を確認しています"

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "OutSystemsExamDrill.NetworkStatusMonitor")

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            Task { @MainActor in
                self?.isOnline = path.status == .satisfied
                self?.statusText = path.status == .satisfied ? "オンライン" : "インターネット接続が必要です"
            }
        }
        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }
}

struct OfflineRequiredView: View {
    let statusText: String

    var body: some View {
        ZStack {
            Color.drillBackground.ignoresSafeArea()

            VStack(spacing: 18) {
                Image(systemName: "wifi.exclamationmark")
                    .font(.system(size: 46, weight: .bold))
                    .foregroundStyle(Color.drillBrand)

                VStack(spacing: 8) {
                    Text(statusText)
                        .font(.title3.weight(.black))
                        .foregroundStyle(Color.drillInk)
                    Text("このアプリは広告表示とオンライン確認のため、インターネット接続中のみ使用できます。")
                        .font(.subheadline)
                        .foregroundStyle(Color.drillSubtext)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(24)
            .frame(maxWidth: 360)
            .background(Color.white, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .stroke(Color.drillLine, lineWidth: 1)
            }
            .shadow(color: Color.drillInk.opacity(0.08), radius: 22, x: 0, y: 10)
            .padding(20)
        }
    }
}
