import Foundation
import SwiftData

enum AccountType: Codable, CaseIterable {
    case card
    case savings
    case credit
    
    var string: String {
        switch self {
        case .card: return "Карты"
        case .savings: return "Накопления"
        case .credit: return "Кредиты"
        }
    }
}

enum Currency: Codable, CaseIterable {
    case rub
    
    var symbol: String {
        switch self {
        case .rub: return "₽"
        }
    }
    
    var string: String {
        switch self {
        case .rub: return "Российский рубль"
        }
    }
}

@Model
final class Account {
    @Attribute(.unique)
    var name: String = ""
    var balance: Int64 = 0
    @Relationship(deleteRule: .cascade, inverse: \Operation.account)
    var operations: [Operation]
    var type: AccountType
    var currency: Currency
    var byDefault: Bool
    
    init(name: String, balance: Int64, type: AccountType, currency: Currency, byDefault: Bool, operations: [Operation] = [], id: UUID = UUID()) {
        self.name = name
        self.balance = balance
        self.operations = operations
        self.type = type
        self.currency = currency
        self.byDefault = byDefault
    }
}

extension [Account] {
    var byDefault: Account? {
        return self.first{$0.byDefault}
    }
}
