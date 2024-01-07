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
