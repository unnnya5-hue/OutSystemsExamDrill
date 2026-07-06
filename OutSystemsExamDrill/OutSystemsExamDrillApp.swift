import SwiftUI

@main
struct OutSystemsExamDrillApp: App {
    @StateObject private var store = DrillStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
                .preferredColorScheme(.light)
        }
    }
}
