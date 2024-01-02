import Foundation

class TripFunctions {
    static func create(_ trip: TripModel) {

    }

    static func read() {
        if Data.trips.isEmpty {
            Data.trips.append(.init(title: "Trip to Bali!"))
            Data.trips.append(.init(title: "Mexico"))
            Data.trips.append(.init(title: "Russian Trip"))
        }
    }

    static func update(_ trip: TripModel) {

    }

    static func delete(_ trip: TripModel) {

    }
}
