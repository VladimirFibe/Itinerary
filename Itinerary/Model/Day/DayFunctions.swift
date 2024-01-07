import Foundation

class DayFunctions {
    static func createDays(at tripId: UUID, using day: DayModel) {
        guard let index = Data.trips.firstIndex(where: { $0.id == tripId}) else { return }
        Data.trips[index].days.append(day)
        print(Data.trips[index])
    }
}
