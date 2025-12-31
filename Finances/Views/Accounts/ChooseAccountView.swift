import SwiftUI

struct ChooseAccountView: View {
    let accounts: [Account]
    @Binding var account: Account?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Button("", systemImage: "xmark") {
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Text("Счёт")
                Spacer()
                Button("", systemImage: "plus") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding([.horizontal, .vertical])
            
            List(accounts.filter{ $0.type == AccountType.card}) {
                acc in
                Button() {
                    account = acc
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Text(acc.name)
                        Spacer()
                        Text(" \(acc.balance) \(acc.currency.symbol)")
                    }
                }
            }
        }
    }
}
