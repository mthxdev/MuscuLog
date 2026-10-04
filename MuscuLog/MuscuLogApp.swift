import SwiftUI
import SwiftData

@main
struct MuscuLogApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            Program.self,
            CompletedWorkout.self
        ]) { result in
            if case .success(let container) = result {
                InitialDataLoader.loadIfEmpty(context: container.mainContext)
            }
        }
    }
}
