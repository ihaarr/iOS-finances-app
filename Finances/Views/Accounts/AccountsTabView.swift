import SwiftUI

struct AccountsTabView: View {
    let accounts: [Account]
    
    @State private var showCreateSheet = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Счета")
                Button("", systemImage: "plus") {
                    showCreateSheet = true
                }
                .sheet(isPresented: $showCreateSheet) {}
                content: {
                    CreateAccountView(accounts: accounts, showSelf: $showCreateSheet)
                }
            }
            .padding([.vertical, .horizontal])
            ListCardsView(accounts: accounts)
            ListSavingsView(accounts: accounts)
            ListCreditsView(accounts: accounts)
            Spacer()
        }
        .padding([.vertical, .horizontal])
    }
}
