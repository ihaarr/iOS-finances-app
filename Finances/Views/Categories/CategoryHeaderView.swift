import SwiftUI

struct CategoryHeaderView: View {
    @Binding var categoryType: CategoryType
    @Binding var find: String
    @State private var addCategorySheetPresent = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Категории")
                    .padding([.horizontal, .vertical])
                Spacer()
            }
            HStack {
                TextField("Поиск", text: $find)
                Button("", systemImage: "plus") {
                    addCategorySheetPresent = true
                }
            }
            .padding(.horizontal)
            .sheet(isPresented: $addCategorySheetPresent, content: {
                AddCategorySheetView(toShow: $addCategorySheetPresent, categoryType: categoryType)
            })
        }
    }
}
