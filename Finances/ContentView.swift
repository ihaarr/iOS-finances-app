import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showNewOperation = false
    @State private var showTabView = true
    @Query private var categories: [Category]
    @Query private var accounts: [Account]
    @Query private var operations: [Operation]
    
    var body: some View {
        VStack {
            if showTabView {
                TabView {
                    AccountsTabView(accounts: accounts)
                        .tabItem {
                            Label("Счета", systemImage: "")
                        }
                    OperationsTabView(categories: categories, accounts: accounts, operations: operations)
                        .tabItem {
                            Label("Операции", systemImage: "")
                        }
                    CategoriesTabView(categories: categories, categoryType: CategoryType.expenses)
                        .tabItem {
                            Label("Категории", systemImage: "")
                        }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
