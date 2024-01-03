import Foundation

class TripFunctions {
    static func create(_ trip: TripModel) {
        Data.trips.append(trip)
    }

    static func read(comletion: @escaping () -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            if Data.trips.isEmpty {
                Data.trips.append(.init(title: "Trip to Bali!"))
                Data.trips.append(.init(title: "Mexico"))
                Data.trips.append(.init(title: "Russian Trip"))
            }

            DispatchQueue.main.async {
                comletion()
            }
        }
    }

    static func update(_ trip: TripModel) {

    }

    static func delete(_ trip: TripModel) {
        Data.trips.removeAll(where: {$0.id == trip.id })
    }
}
