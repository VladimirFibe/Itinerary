import Foundation

class TripFunctions {
    static func create(_ trip: TripModel) {
        Data.trips.append(trip)
    }

    static func readTrips(comletion: @escaping ([TripModel]) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            if Data.trips.isEmpty {
                Data.createMockTripModelData()
            }

            DispatchQueue.main.async {
                comletion(Data.trips)
            }
        }
    }

    static func readTrip(id: UUID, completion: @escaping (TripModel?) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            let trip = Data.trips.first(where: { $0.id == id })
            DispatchQueue.main.async { completion(trip)}
        }
    }

    static func update(_ trip: TripModel) {
        guard let index = Data.trips.firstIndex(where: { $0.id == trip.id}) else { return }
        Data.trips[index] = trip
        print(Data.trips)
    }

    static func delete(_ trip: TripModel) {
        Data.trips.removeAll(where: { $0.id == trip.id })
    }
}
