import SwiftUI

struct CategoryRow: View {
    var category: Category
    @State private var expanded = false
    @Binding var toShow: Bool
    @Binding var chooseSubcategory: Subcategory?
    
    var body: some View {
        VStack {
            HStack {
                Text(category.name)
                Button("", systemImage: !expanded ? "arrowtriangle.right.fill" : "arrowtriangle.down.fill") {
                    expanded.toggle()
                }
                .foregroundStyle(Color.gray)
                Spacer()
            }
            .padding(.horizontal)
            
            if expanded {
                ForEach(category.subcategories) {
                    subcategory in
                    Button() {
                        chooseSubcategory = subcategory
                        toShow = false
                    } label: {
                        Text(subcategory.name)
                    }
                }
                .padding(.vertical)
            }
        }
    }
}


struct ListCategoriesView: View {
    var categoryType: CategoryType
    var categories: [Category]
    
    @Binding var toShow: Bool
    @Binding var chooseSubcategory: Subcategory?
    
    var body: some View {
        List(categories) {
            category in
            if category.type == categoryType {
                CategoryRow(category: category, toShow: $toShow, chooseSubcategory: $chooseSubcategory)
            }
        }
        .padding(.horizontal)
        .listStyle(.grouped)
    }
}
