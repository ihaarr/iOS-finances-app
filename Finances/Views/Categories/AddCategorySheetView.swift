import SwiftUI
import SwiftData

struct AddCategorySheetView: View {
    @Binding var toShow: Bool
    var categoryType: CategoryType
    
    @State private var showChooseParent = false
    @State private var parentCategory: Category? = nil
    @State private var name = ""
    @State private var didError = false
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        VStack {
            ZStack {
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
                    Button("", systemImage: "checkmark", action: {
                        if name.isEmpty {
                            print("Empty")
                        } else {
                            do {
                                if let parentCategory {
                                    try insert(subcategory: Subcategory(name: name, category: parentCategory))
                                } else {
                                    try insert(category: Category(name: name, type: categoryType))
                                }
                                toShow = false
                            } catch {
                                didError = true
                            }
                        }
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
            Section("Родительская категория") {
                Button(action: {
                    showChooseParent = true
                }, label: {
                    if let parentCategory {
                        Text(parentCategory.name)
                    } else {
                        let circle = Image(systemName: "circle.slash")
                        Text("\(circle) Нет")
                    }
                })
            }
            TextField("Название", text: $name)
            Spacer()
        }
        .sheet(isPresented: $showChooseParent) {
            
        } content: {
            ChooseParentCategorySheet(toShow: $showChooseParent, parentCategory: $parentCategory, categoryType: categoryType)
        }
    }
    
    private func insert(category: Category) throws {
        context.insert(category)
        try context.save()
        print("Category created")
    }
    
    private func insert(subcategory: Subcategory) throws {
        print(subcategory.category.name)
        context.insert(subcategory)
        try context.save()
        print("Subcategory created")
    }
}
