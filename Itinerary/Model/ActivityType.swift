import UIKit

enum ActivityType {
    case car
    case excursion
    case flight
    case food
    case hotel

    var image: UIImage {
        switch self {
        case .car:          return .car
        case .excursion:    return .excursion
        case .flight:       return .flight
        case .food:         return .food
        case .hotel:        return .hotel
        }
    }
}
