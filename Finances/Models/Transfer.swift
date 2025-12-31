import SwiftData

@Model
final class Transfer {
    var from: Account
    var to: Account
    var cost: Int64

    init(from: Account, to: Account, cost: Int64) {
        self.from = from
        self.to = to
        self.cost = cost
    }
}
