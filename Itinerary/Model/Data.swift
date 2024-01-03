import Foundation

class Data {
    static var trips: [TripModel] = [] {
        didSet {
            trips.forEach { print($0.title)}
        }
    }
}
