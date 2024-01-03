import UIKit

struct TripModel: Hashable {

    let id: UUID
    var title: String
    var image: UIImage?
    
    init(title: String, image: UIImage? = nil) {
        id = UUID()
        self.title = title
        self.image = image
    }
}
