import SwiftUI
import SwiftData

struct CategoryRow: View {
    var category: Category
    
    @State private var expanded = false
    
    var body: some View {
        VStack {
            HStack {
                Text(category.name)
                Spacer()
                Button("", systemImage: !expanded ? "arrowtriangle.right.fill" : "arrowtriangle.down.fill") {
                    expanded = !expanded
                }
                Button("", systemImage: "plus") {
                    
                }
            }
            .padding(.horizontal)
            
            if expanded {
                ForEach(category.subcategories) {
                    subcategory in
                    Text(subcategory.name)
                }
                .padding(.vertical)
            }
        }
    }
}

struct CategoriesTabView: View {
    @State private var find = ""
    @State private var addCategorySheetPresent = false
    @State private var categoryType: CategoryType = CategoryType.expenses
    @Query private var categories: [Category]
    var body: some View {
        VStack {
            HStack {
                TextField("Поиск", text: $find)
                Button("", systemImage: "plus") {
                    addCategorySheetPresent = true
                }
            }
            .padding(.horizontal)
            .sheet(isPresented: $addCategorySheetPresent) {
                
            } content: {
                AddCategorySheetView(toShow: $addCategorySheetPresent, categoryType: $categoryType)
            }
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
            VStack {
                List(categories) {
                    category in
                    if category.type == categoryType {
                        CategoryRow(category: category)
                    }
                }
                .padding(.horizontal)
                .listStyle(.grouped)
            }
            .frame(maxHeight: .infinity)
        }
    }
}
