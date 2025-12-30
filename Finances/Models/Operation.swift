import Foundation
import SwiftData

@Model
final class Operation {
    var cost: Int64
    var account: Account
    var subcategory: Subcategory
    var date: Date
    
    init(cost: Int64, account: Account, subcategory: Subcategory, date: Date) {
        self.cost = cost
        self.account = account
        self.subcategory = subcategory
        self.date = date
    }
}
