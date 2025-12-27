import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TabView {
                AccountsTabView()
                    .tabItem {
                        Label("Счета", systemImage: "")
                    }
                CategoriesTabView()
                    .tabItem {
                        Label("Категории", systemImage: "")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
