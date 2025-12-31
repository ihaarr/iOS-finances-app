import SwiftUI

struct ChooseCategoryView: View {
    let categories: [Category]
    let categoryType: CategoryType
    @Binding var chooseCategory: Subcategory?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Button("", systemImage: "xmark") {
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
                Text("Категории")
                Spacer()
                Button("", systemImage: "plus") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding([.horizontal, .vertical])
            ListCategoriesView(categoryType: categoryType, categories: categories, chooseSubcategory: $chooseCategory)
        }
    }
}
