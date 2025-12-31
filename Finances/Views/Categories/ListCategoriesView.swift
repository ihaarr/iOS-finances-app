import SwiftUI

struct CategoryRow: View {
    var category: Category
    @State private var expanded = false
    @Binding var chooseSubcategory: Subcategory?
    @Environment(\.presentationMode) var presentationMode
    
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
                        presentationMode.wrappedValue.dismiss()
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
    
    @Binding var chooseSubcategory: Subcategory?
    
    var body: some View {
        List(categories) {
            category in
            if category.type == categoryType {
                CategoryRow(category: category, chooseSubcategory: $chooseSubcategory)
            }
        }
        .padding(.horizontal)
        .listStyle(.grouped)
    }
}
