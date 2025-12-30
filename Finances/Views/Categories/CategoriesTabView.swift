import SwiftUI
import SwiftData

struct CategoriesTabView: View {
    var categories: [Category]
    @State var categoryType: CategoryType = CategoryType.expenses
    @State private var find = ""
    @State private var __C: Subcategory?
    @State private var __S: Bool = false
    var body: some View {
        VStack {
            CategoryHeaderView(categoryType: $categoryType, find: $find)
            HStack {
                Button("Расходы") {
                    categoryType = CategoryType.expenses
                }
                .underline(categoryType == CategoryType.expenses, color: Color.black)
                Button("Доходы") {
                    categoryType = CategoryType.income
                }
                .underline(categoryType == CategoryType.income, color: Color.black)
            }
            ListCategoriesView(categoryType: categoryType, categories: categories, toShow: $__S, chooseSubcategory: $__C)
        }
    }
}
