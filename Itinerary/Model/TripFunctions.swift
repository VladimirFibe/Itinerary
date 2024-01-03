import Foundation

class TripFunctions {
    static func create(_ trip: TripModel) {
        StorageManager.trips.append(trip)
    }

    static func read(comletion: @escaping ([TripModel]) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            if StorageManager.trips.isEmpty {
                StorageManager.trips.append(.init(title: "Trip to Bali!"))
                StorageManager.trips.append(.init(title: "Mexico"))
                StorageManager.trips.append(.init(title: "Russian Trip"))
            }

            DispatchQueue.main.async {
                comletion(StorageManager.trips)
            }
        }
    }

    static func update(_ trip: TripModel) {
        guard let index = StorageManager.trips.firstIndex(where: { $0.id == trip.id}) else { return }
        StorageManager.trips[index] = trip
        print(StorageManager.trips)
    }

    static func delete(_ trip: TripModel) {
        StorageManager.trips.removeAll(where: { $0.id == trip.id })
    }
}
