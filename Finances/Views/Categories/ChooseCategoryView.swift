import SwiftUI

struct ChooseCategoryView: View {
    let categories: [Category]
    let categoryType: CategoryType
    @Binding var toShow: Bool
    @Binding var chooseCategory: Subcategory?
    
    var body: some View {
        VStack {
            HStack {
                Button("", systemImage: "xmark") {
                    toShow = false
                }
                Spacer()
                Text("Категории")
                Spacer()
                Button("", systemImage: "plus") {
                    toShow = false
                }
            }
            .padding([.horizontal, .vertical])
            ListCategoriesView(categoryType: categoryType, categories: categories, toShow: $toShow, chooseSubcategory: $chooseCategory)
        }
    }
}
