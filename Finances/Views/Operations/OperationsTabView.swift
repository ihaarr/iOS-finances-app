import SwiftUI

struct OperationsTabView: View {
    let categories: [Category]
    let accounts: [Account]
    let operations: [Operation]
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
                    .sheet(isPresented: $showNewOperationView, content: {
                        NewOperationView(categories: categories, accounts: accounts, toShow: $showNewOperationView)
                    })
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
            List(operations) {
                operation in
                HStack {
                    VStack {
                        Text(operation.subcategory.name)
                        Text(operation.date.formatted(date: .abbreviated, time: .omitted))
                    }
                    Spacer()
                    Text("-\(operation.cost) ₽")
                        .foregroundStyle(Color.red)
                }
            }
        }
    }
}
