import SwiftUI
import SwiftData


struct NewOperationView: View {
    var categories: [Category]
    var accounts: [Account]
    @Binding var toShow: Bool
    
    @State private var currentSubcategory: Subcategory? = nil
    @State private var cost = ""
    @State private var currentCategoryType: CategoryType = CategoryType.expenses
    @State private var currentAccount: Account? = nil
    @State private var currentDate: Date = Date.now
    @State private var changeDate = false
    
    @State private var showAccountChoose = false
    @State private var showCategoryChoose = false
    @Environment(\.modelContext) private var context
    
    private var filteredCost: Binding<String> {
            Binding(
                get: { cost },
                set: { newValue in
                    let filtered = newValue.filter { $0.isNumber || $0 == "." }
                    // Remove leading zeros if there's more than one digit
                    if filtered.count > 1 && filtered.first == "0" && !filtered.contains(".") {
                        cost = String(filtered.dropFirst())
                    } else {
                        cost = filtered
                    }
                }
            )
        }
    
    var body: some View {
        VStack {
            HStack {
                Button("", systemImage: "xmark") {
                    toShow = false
                }
                Spacer()
                HStack {
                    Button("Расходы") {
                        currentCategoryType = CategoryType.expenses
                    }
                    .underline(currentCategoryType == CategoryType.expenses, color: Color.black)
                    Button("Доходы") {
                        currentCategoryType = CategoryType.income
                    }
                    .underline(currentCategoryType == CategoryType.income, color: Color.black)
                }
                Spacer()
                Button("", systemImage: "checkmark", action: {
                    let acc = currentAccount ?? accounts.first!
                    let cost = Int64(cost)!
                    let operation = Operation(cost: cost, account: acc, subcategory: currentSubcategory!, date: currentDate)
                    
                    acc.balance -= cost
                    acc.operations.append(operation)
                    context.insert(operation)
                    do {
                        try context.save()
                    } catch {
                        print("Failed to create operation: \(error)")
                    }
                    toShow = false
                })
            }
            .padding([.horizontal, .vertical])
            List {
                TextField("", text: filteredCost)
                    .keyboardType(.decimalPad)
                
                //Subcategory
                Button() {
                    showCategoryChoose = true
                } label: {
                    HStack {
                        Text("Подкатегория")
                            .foregroundColor(.gray)
                        Spacer()
                        if let currentSubcategory {
                            Text("\(currentSubcategory.category.name).\(currentSubcategory.name)")
                        } else {
                            let circle = Image(systemName: "circle.slash")
                            Text("\(circle) Без подкатегории")
                        }
                    }
                }
                .sheet(isPresented: $showCategoryChoose) {
                    
                } content: {
                    ChooseCategoryView(categories: categories, categoryType: currentCategoryType, toShow: $showCategoryChoose, chooseCategory: $currentSubcategory)
                }
                
                //Account
                Button() {
                    showAccountChoose = true
                } label: {
                    HStack {
                        Text("Счёт")
                            .foregroundColor(.gray)
                        Spacer()
                        if let currentAccount {
                            Text(currentAccount.name)
                        } else {
                            Text(accounts.first?.name ?? "Нет счета")
                        }
                    }
                }
                .sheet(isPresented: $showAccountChoose) {
                    
                } content: {
                    ChooseAccountView(accounts: accounts, toShow: $showAccountChoose, account: $currentAccount)
                }
                
                //Date
                Button() {
                    changeDate.toggle()
                } label: {
                    HStack {
                        Text("Дата")
                            .foregroundColor(.gray)
                        Spacer()
                        if Calendar.current.isDateInToday(currentDate) {
                            Text("Сейчас")
                        } else {
                            Text(currentDate.formatted(date: .abbreviated, time: .omitted))
                        }
                    }
                }
                
                if changeDate {
                    DatePicker("Select Date", selection: $currentDate, displayedComponents: [.date])
                            .padding(.horizontal)
                            .datePickerStyle(.graphical)
                }
            }
        }
    }
}
