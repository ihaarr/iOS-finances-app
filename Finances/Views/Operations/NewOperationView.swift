import SwiftUI
import SwiftData

struct NewOperationChooseAccountView: View {
    let accounts: [Account]
    
    @Binding var transferCost: String
    @Binding var accountFrom: Account?
    @Binding var accountTo: Account?
    
    @State private var changeDate = false
    @State private var currentDate: Date = Date.now
    @State private var sheet: Sheet?
    
    enum Sheet: Identifiable {
        case from, to
        
        var id: Int {
          hashValue
        }
    }
    
    var body: some View {
        List {
            TextField("", text: $transferCost)
            Button() {
                sheet = Sheet.from
            } label: {
                HStack {
                    Text("Откуда")
                        .foregroundColor(.gray)
                    Spacer()
                    if let accountFrom {
                        Text(accountFrom.name)
                    } else {
                        Text(accounts.byDefault?.name ?? "Нет счета")
                    }
                }
            }

            Button() {
                sheet = Sheet.to
            } label: {
                HStack {
                    Text("Куда")
                        .foregroundColor(.gray)
                    Spacer()
                    if let accountTo {
                        Text(accountTo.name)
                    } else {
                        Text(accounts.byDefault?.name ?? "Нет счета")
                    }
                }
            }
            
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
        .sheet(item: $sheet) {
            sheet in
            switch sheet {
            case .from:
                ChooseAccountView(accounts: accounts, account: $accountFrom)
            case .to:
                ChooseAccountView(accounts: accounts, account: $accountTo)
            }
        }
    }
}

struct NewOperationView: View {
    var categories: [Category]
    var accounts: [Account]
    @Binding var toShow: Bool
    
    @State private var currentSubcategory: Subcategory? = nil
    @State private var cost = ""
    @State private var currentCategoryType: CategoryType = CategoryType.expenses
    
    @State private var transfer = false
    @State private var transferCost = ""
    @State private var transferFromAccount: Account?
    @State private var transferToAccount: Account?
    
    @State private var currentAccount: Account? = nil
    @State private var currentDate: Date = Date.now
    @State private var changeDate = false
    
    @State private var sheet: Sheet?
    @State private var showTransferChoose = false
    
    enum Sheet: Identifiable {
        case account, category
        
        var id: Int {
            hashValue
        }
    }

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
    
    private func create() {
        if transfer {
            let from = transferFromAccount ?? accounts.byDefault!
            let to = transferToAccount ?? accounts.byDefault!
            let cost = Int64(cost)!
            
            //TODO: Same currency only
            if from != to {
                from.balance -= cost
                to.balance += cost
                let op = Transfer(from: from, to: to, cost: cost)
                context.insert(op)
                print("Insert transfer")
                do {
                    try context.save()
                } catch {
                    fatalError("Failed to create transfer: \(error)")
                }
            }
        } else {
            let acc = currentAccount ?? accounts.byDefault!
            let cost = Int64(cost)!
            let operation = Operation(cost: cost, account: acc, subcategory: currentSubcategory!, date: currentDate)
            
            acc.balance -= cost
            acc.operations.append(operation)
            context.insert(operation)
            print("Insert operation")
            do {
                try context.save()
            } catch {
                fatalError("Failed to create operation: \(error)")
            }
        }
        toShow = false
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
                        transfer = false
                    }
                    .underline(!transfer && currentCategoryType == CategoryType.expenses, color: Color.black)
                    Button("Доходы") {
                        currentCategoryType = CategoryType.income
                        transfer = false
                    }
                    .underline(!transfer && currentCategoryType == CategoryType.income, color: Color.black)
                    Button("Перевод") {
                        transfer = true
                    }
                    .underline(transfer, color: Color.black)
                }
                Spacer()
                Button("", systemImage: "checkmark", action: create)
            }
            .padding([.horizontal, .vertical])
            if transfer {
                NewOperationChooseAccountView(accounts: accounts, transferCost: $cost, accountFrom: $transferFromAccount, accountTo: $transferToAccount)
            } else {
                List {
                    TextField("", text: filteredCost)
                        .keyboardType(.decimalPad)
                    
                    //Subcategory
                    Button() {
                        sheet = .category
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
                    
                    //Account
                    Button() {
                        sheet = .account
                    } label: {
                        HStack {
                            Text("Счёт")
                                .foregroundColor(.gray)
                            Spacer()
                            if let currentAccount {
                                Text(currentAccount.name)
                            } else {
                                Text(accounts.byDefault?.name ?? "Нет счета")
                            }
                        }
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
                .sheet(item: $sheet) {
                    sheet in
                    switch sheet {
                    case .account:
                        ChooseAccountView(accounts: accounts,account: $currentAccount)
                    case .category:
                        ChooseCategoryView(categories: categories, categoryType: currentCategoryType, chooseCategory: $currentSubcategory)
                    }
                }
            }
        }
    }
}
