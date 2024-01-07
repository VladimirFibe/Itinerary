import Foundation

struct DayModel {
    var id: String!
    var title = Date()
    var subtitle = ""
    var activityModels = [ActivityModel]()

    init(
        title: Date,
        subtitle: String,
        data: [ActivityModel]?
    ) {
        id = UUID().uuidString
        self.title = title
        self.subtitle = subtitle

        if let data = data {
            self.activityModels = data
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
