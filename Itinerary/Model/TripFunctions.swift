import Foundation

class TripFunctions {
    static func create(_ trip: TripModel) {
        Data.trips.append(trip)
    }

    static func read(comletion: @escaping ([TripModel]) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            if Data.trips.isEmpty {
                Data.createMockTripModelData()
            }

            DispatchQueue.main.async {
                comletion(Data.trips)
            }
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
