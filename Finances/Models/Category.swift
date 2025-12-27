import Foundation
import SwiftData

enum CategoryType: Codable {
    case income
    case expenses
    
    var string: String {
        switch self {
        case .income: return "Доходы"
        case .expenses: return "Расходы"
        }
    }
}

@Model
final class Category {
    @Attribute(.unique)
    var id: UUID
    @Attribute(.unique)
    var name: String = ""
    var type: CategoryType
    
    @Relationship(deleteRule: .cascade, inverse: \Subcategory.category)
    var subcategories: [Subcategory]
    
    init(name: String, type: CategoryType, subcategories: [Subcategory] = [], id: UUID = UUID()) {
        self.id = id
        self.name = name
        self.type = type
        self.subcategories = subcategories
    }
}
