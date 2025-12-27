import SwiftUI
import SwiftData

@main
struct FinancesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Category.self,
            Subcategory.self,
            Account.self
        ])
        var isStoredInMemoryOnly = false
        #if DEBUG
        isStoredInMemoryOnly = true
        #endif
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: isStoredInMemoryOnly)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
