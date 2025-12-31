import SwiftUI

struct OperationsTabView: View {
    let categories: [Category]
    let accounts: [Account]
    let operations: [Operation]
    let transfers: [Transfer]
    @State private var showNewOperationView = false
    @State private var categoryType: CategoryType = CategoryType.expenses
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Операции")
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .center)
                HStack {
                    Button("", systemImage: "line.3.horizontal.decrease") {
                        
                    }
                    Button("", systemImage: "plus") {
                        showNewOperationView = true
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
            List(transfers) {
                transfer in
                HStack {
                    VStack {
                        Text(transfer.from.name)
                        Text(transfer.to.name)
                    }
                    Spacer()
                    Text("\(transfer.cost) \(transfer.from.currency.symbol)")
                }
            }
            List(operations) {
                operation in
                HStack {
                    VStack {
                        Text(operation.subcategory.name)
                        Text(operation.date.formatted(date: .abbreviated, time: .omitted))
                    }
                    Spacer()
                    Text("-\(operation.cost) \(operation.account.currency.symbol)")
                        .foregroundStyle(Color.red)
                }
            }
        }
        .sheet(isPresented: $showNewOperationView, content: {
            NewOperationView(categories: categories, accounts: accounts, toShow: $showNewOperationView)
        })
    }
}
