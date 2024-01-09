import Foundation

class ActivityFunctions {
    static func createActivity(at trip: TripModel, for dayIndex: Int, using activity: ActivityModel) {
        guard let tripIndex = Data.trips.firstIndex(of: trip) else { return }
        Data.trips[tripIndex].days[dayIndex].activities.append(activity)
    }
}
