import Foundation
import SwiftData

@Model
final class Subcategory {
    @Attribute(.unique)
    var id: UUID
    @Attribute(.unique)
    var name: String
    var category: Category
    
    init(name: String, category: Category, id: UUID = UUID()) {
        self.id = id
        self.name = name
        self.category = category
    }
}
