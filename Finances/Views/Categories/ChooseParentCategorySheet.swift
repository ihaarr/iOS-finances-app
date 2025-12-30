import SwiftUI
import SwiftData

struct ChooseParentCategorySheet: View {
    @Binding var toShow: Bool
    @Binding var parentCategory: Category?
    var categoryType: CategoryType
    
    @State private var didError = false
    @Query private var categories: [Category]
    var body: some View {
        VStack {
            HStack {
                Button("", systemImage: "xmark") {
                    toShow = false
                }
                Spacer()
                VStack(spacing: 4) {
                    Text("Новая категория")
                    Text(categoryType.string)
                }
                Spacer()
                Button("", systemImage: "plus", action: {
                    
                })
                .alert("Не удалось создать", isPresented: $didError) {
                    Button("OK") {
                        
                    }
                } message: {
                    Text("Попробуйте еще")
                }
            }
            .padding(.horizontal)
        }
        List {
            ForEach(categories) {
                category in
                if category.type == categoryType {
                    Button(category.name, action: {
                        parentCategory = category
                        toShow = false
                    })
                }
            }
        }
    }
}
