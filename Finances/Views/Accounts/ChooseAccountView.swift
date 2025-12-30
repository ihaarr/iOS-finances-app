import SwiftUI

struct ChooseAccountView: View {
    let accounts: [Account]
    @Binding var toShow: Bool
    @Binding var account: Account?
    
    var body: some View {
        VStack {
            HStack {
                Button("", systemImage: "xmark") {
                    toShow = false
                }
                Spacer()
                Text("Счёт")
                Spacer()
                Button("", systemImage: "plus") {
                    toShow = false
                }
            }
            .padding([.horizontal, .vertical])
            
            List(accounts) {
                acc in
                Button() {
                    account = acc
                    toShow = false
                } label: {
                    HStack {
                        Text(acc.name)
                        Spacer()
                        Text(" \(acc.balance) ₽")
                    }
                }
            }
        }
    }
}
