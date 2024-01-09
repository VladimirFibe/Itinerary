import Foundation

struct DayModel {
    var id: String!
    var title = Date()
    var subtitle = ""
    var activities = [ActivityModel]()

    init(
        title: Date,
        subtitle: String,
        activities: [ActivityModel]?
    ) {
        id = UUID().uuidString
        self.title = title
        self.subtitle = subtitle

        if let data = activities {
            self.activities = data
        }
    }
}

extension DayModel: Comparable {
    static func < (lhs: DayModel, rhs: DayModel) -> Bool {
        lhs.title < rhs.title
    }
    
    static func == (lhs: DayModel, rhs: DayModel) -> Bool {
        lhs.id == rhs.id
    }
}
