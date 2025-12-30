import SwiftUI

struct ListAccountsView: View {
    let accounts: [Account]
    
    var body: some View {
        ForEach(accounts) {
            account in
            HStack {
                Text(account.name)
                Spacer()
                Text("\(account.balance) ₽")
            }
        }
    }
}
