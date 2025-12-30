import Foundation
import SwiftData

@Model
final class Subcategory {
    @Attribute(.unique)
    var name: String
    var category: Category
    
    init(name: String, category: Category) {
        self.name = name
        self.category = category
        category.subcategories.append(self)
    }
}
