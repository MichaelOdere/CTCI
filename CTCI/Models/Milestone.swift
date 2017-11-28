import Foundation

class Milestone {
    
    var title:String!
    var desc:String!
    // Days given to complete
    var days:Int!
    // Total days thus far
    var totalDays:Int!

    init(title: String, desc: String, days: Int, totalDays: Int) {
        self.title = title
        self.desc = desc
        self.days = days
        self.totalDays = totalDays
    }
}
