import SwiftUI

struct ListCreditsView: View {
    let accounts: [Account]
    
    @State private var expanded = false
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    expanded.toggle()
                }
            }) {
                HStack(spacing: 8) {
                    Text(AccountType.credit.string)
                        .foregroundColor(.white)
                        .font(.body)

                    Image(
                        systemName: !expanded
                            ? "chevron.down" : "chevron.right"
                    )
                    .foregroundColor(.white)
                    .font(.caption)

                    Spacer()
                }
                .padding(.vertical, 12)
                .contentShape(Rectangle())  // Для увеличения области нажатия
            }
            .buttonStyle(PlainButtonStyle())  // Убирает стандартные стили кнопки
            .background(Color.black)  // Фон элемента
            .clipShape(RoundedRectangle(cornerRadius: 0))  // Без скруглений, как в
            if expanded {
                ForEach(accounts.filter{$0.type == AccountType.credit}) {
                    account in
                    HStack {
                        Text(account.name)
                        Spacer()
                        Text("\(account.balance) \(account.currency.symbol)")
                    }
                }
            }
        }
    }
}
