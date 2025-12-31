import SwiftUI
import SwiftData

struct ChooseAccountTypeView: View {
    @Binding var showSelf: Bool
    @Binding var type: AccountType
    
    var body: some View {
        VStack {
            HStack {
                Button("", systemImage: "xmark") {
                    showSelf = false
                }
                Spacer()
                Text("Выбор типа")
                Spacer()
                Button("", systemImage: "plus") {
                    showSelf = false
                }
            }
            .padding([.vertical, .horizontal])
        }
        ForEach(AccountType.allCases, id: \.self) {
            t in
            Button(t.string, action: {
                type = t
                showSelf = false
            })
        }
    }
}

struct ChooseCurrencyView: View {
    @Binding var showSelf: Bool
    @Binding var currency: Currency
    
    var body: some View {
        VStack {
            HStack {
                Button("", systemImage: "xmark") {
                    showSelf = false
                }
                Spacer()
                Text("Счет")
                Spacer()
                Button("", systemImage: "plus") {
                    showSelf = false
                }
            }
            .padding([.vertical, .horizontal])
        }
        ForEach(Currency.allCases, id: \.self) {
            t in
            Button(t.string, action: {
                currency = t
                showSelf = false
            })
        }
    }
}

struct CreateAccountView: View {
    let accounts: [Account]
    @Binding var showSelf: Bool
    
    @State private var sheet = SheetContent.type
    @State private var showSheet = false
    
    @State private var name = ""
    @State private var type = AccountType.card
    @State private var currency = Currency.rub
    @State private var balance = ""
    @State private var toggleByDefault = false
    
    enum SheetContent {
        case type, currency
    }
    
    var byDefault: Bool {
        return type == AccountType.card && toggleByDefault
    }
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        VStack {
            HStack {
                Button("", systemImage: "xmark") {
                    showSelf = false
                }
                Spacer()
                Text("Создание счета")
                Spacer()
                Button("", systemImage: "plus") {
                    let acc = Account(name: name, balance: Int64(balance)!, type: type, currency: currency, byDefault: byDefault)
                    context.insert(acc)
                    if byDefault {
                        accounts.byDefault?.byDefault = false
                    }
                    do {
                        try context.save()
                    } catch {
                        fatalError("Failed to create account: \(error)")
                    }
                    
                    showSelf = false
                }
            }
            .padding([.vertical, .horizontal])
            
            List {
                TextField("Название", text: $name)
                
                Button() {
                    sheet = SheetContent.type
                    showSheet = true
                } label: {
                    Text(type.string)
                }
                
                Button() {
                    sheet = SheetContent.currency
                    showSheet = true
                } label: {
                    Text(currency.string)
                }
                
                TextField("Баланс", text: $balance)
                if type == AccountType.card {
                    Toggle("Сделать по умолчанию?", isOn: $toggleByDefault)
                        .toggleStyle(.switch)
                }
            }
            .sheet(isPresented: $showSheet, content: {
                switch sheet {
                case .type: ChooseAccountTypeView(showSelf: $showSheet, type: $type)
                case .currency: ChooseCurrencyView(showSelf: $showSheet, currency: $currency)
                }
            })
            
            Spacer()
        }
        .padding([.vertical, .horizontal])
    }
}
