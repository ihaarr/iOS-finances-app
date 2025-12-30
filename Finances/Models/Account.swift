import Foundation
import SwiftData

@Model
final class Account {
    @Attribute(.unique)
    var name: String = ""
    var balance: Int64 = 0
    @Relationship(deleteRule: .cascade, inverse: \Operation.account)
    var operations: [Operation]
    
    init(name: String, balance: Int64, operations: [Operation] = [], id: UUID = UUID()) {
        self.name = name
        self.balance = balance
        self.operations = operations
    }
}
