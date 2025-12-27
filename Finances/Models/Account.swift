import Foundation
import SwiftData

@Model
final class Account {
    @Attribute(.unique)
    var id: UUID
    @Attribute(.unique)
    var name: String = ""
    var balance: UInt64 = 0
    
    init(name: String, balance: UInt64, id: UUID = UUID()) {
        self.id = id
        self.name = name
        self.balance = balance
    }
}
