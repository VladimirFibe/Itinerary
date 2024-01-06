import UIKit

struct TripModel: Hashable {
    let id: UUID
    var title: String
    var image: UIImage?
    var days: [DayModel] = []
    
    init(
        title: String,
        image: UIImage? = nil,
        days: [DayModel]? = nil
    ) {
        id = UUID()
        self.title = title
        self.image = image
        if let days {
            self.days = days
        }
    }
    static func == (lhs: TripModel, rhs: TripModel) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
    }
}
