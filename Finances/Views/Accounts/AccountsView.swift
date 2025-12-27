import SwiftUI
import SwiftData

struct AccountsView: View {
    @State private var isExpanded = false
    @Environment(\.modelContext)
    private var modelContext
    @Query
    private var accounts: [Account]
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isExpanded = !isExpanded
                }
            }) {
                HStack(spacing: 8) {
                    Text("Карты и счета")
                        .foregroundColor(.white)
                        .font(.body)

                    Image(
                        systemName: !isExpanded
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
            if isExpanded {
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
    }
}
