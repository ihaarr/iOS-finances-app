import SwiftUI
import SwiftData

@main
struct FinancesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Category.self,
            Subcategory.self,
            Account.self,
            Operation.self,
            Transfer.self,
        ])
        var isStoredInMemoryOnly = false
        #if DEBUG
        isStoredInMemoryOnly = true
        #endif
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: isStoredInMemoryOnly)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            #if DEBUG
            let incomeCategory = Category(name: "income category", type: CategoryType.income)
            let incomeSubcategory = Subcategory(name: "income subcategory", category: incomeCategory)
            container.mainContext.insert(incomeCategory)
            container.mainContext.insert(incomeSubcategory)
            
            let expenseCategory = Category(name: "expense category", type: CategoryType.expenses)
            let expenseSubcategory = Subcategory(name: "expense subcategory", category: expenseCategory)
            
            container.mainContext.insert(expenseCategory)
            container.mainContext.insert(expenseSubcategory)
            
            let account = Account(name: "Наличные", balance: 1000, type: AccountType.card, currency: Currency.rub, byDefault: false)
            let account2 = Account(name: "Карта", balance: 2000, type: AccountType.card, currency: Currency.rub, byDefault: true)
            let account3 = Account(name: "Депозит", balance: 50000, type: AccountType.savings, currency: Currency.rub, byDefault: false)
            container.mainContext.insert(account)
            container.mainContext.insert(account2)
            container.mainContext.insert(account3)
            try container.mainContext.save()
            #endif
            return container
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
