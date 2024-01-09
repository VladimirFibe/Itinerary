import Foundation

class Data {
    static var trips: [TripModel] = []
    static func createMockTripModelData() {
        trips = [
            .init(title: "Trip to Bali!", image: .bali, days: createmockDayModelData()),
            .init(title: "Mexico", image: .mexico),
            .init(title: "Russian Trip", image: .russia)
        ]
    }

    static func createmockDayModelData() -> [DayModel] {
        var dayModels = [DayModel]()
        let today = Date()
        dayModels.append(DayModel(
            title: Date(),
            subtitle: "Departure",
            activities: createMockActivityModelData(sectionTitle: "April 18")
        ))
        dayModels.append(DayModel(
            title: today.add(days: 1),
            subtitle: "Exploring",
            activities: createMockActivityModelData(sectionTitle: "April 19")
        ))
        dayModels.append(DayModel(
            title: today.add(days: 2),
            subtitle: "Scuba Diving!",
            activities: createMockActivityModelData(sectionTitle: "April 20")
        ))
        dayModels.append(DayModel(
            title: today.add(days: 3),
            subtitle: "Volunteering",
            activities: createMockActivityModelData(sectionTitle: "April 21")
        ))
        dayModels.append(DayModel(
            title: today.add(days: 4),
            subtitle: "Time to go back home",
            activities: createMockActivityModelData(sectionTitle: "April 22")
        ))
        return dayModels
    }

    static func createMockActivityModelData(sectionTitle: String) -> [ActivityModel] {
        var models = [ActivityModel]()

        switch sectionTitle {
        case "April 18":
            models.append(ActivityModel(title: "SLC", subTitle: "12:25 - 13:45", activityType: ActivityType.flight, photo: #imageLiteral(resourceName: "deleteSwipe")))
            models.append(ActivityModel(title: "LAX", subTitle: "17:00 - 11:00", activityType: ActivityType.flight))
        case "April 19":
            models.append(ActivityModel(title: "DPS", subTitle: "", activityType: ActivityType.flight))
            models.append(ActivityModel(title: "Bintang Kuta Hotel Checkin", subTitle: "Confirmation: AX76Y2", activityType: ActivityType.hotel))
            models.append(ActivityModel(title: "Pick up rental", subTitle: "Confirmation: 996464", activityType: ActivityType.car))
            models.append(ActivityModel(title: "Island Excusion", subTitle: "Touring the island", activityType: ActivityType.excursion))
            models.append(ActivityModel(title: "Dinner", subTitle: "at Warung Sanur Segar", activityType: ActivityType.food))
        case "April 20":
            models.append(ActivityModel(title: "Scuba Diving", subTitle: "Checking out the Reefs!", activityType: ActivityType.excursion))
            models.append(ActivityModel(title: "Dinner", subTitle: "at Malaika Secret Moksha", activityType: ActivityType.food))
        case "April 21":
            models.append(ActivityModel(title: "Travel", subTitle: "to Nusa Penida", activityType: ActivityType.flight))
            models.append(ActivityModel(title: "Volunteering", subTitle: "at Tanglad Village", activityType: ActivityType.excursion))
            models.append(ActivityModel(title: "Dinner", subTitle: "at Warung Made", activityType: ActivityType.food))
            models.append(ActivityModel(title: "Travel", subTitle: "back to Denpasar", activityType: ActivityType.flight))
        case "April 22":
            models.append(ActivityModel(title: "Hotel Checkout", subTitle: "from Bintang Kuta Hotel", activityType: ActivityType.hotel))
            models.append(ActivityModel(title: "DPS", subTitle: "Denpasar", activityType: ActivityType.flight))
            models.append(ActivityModel(title: "LAX", subTitle: "Los Angeles", activityType: ActivityType.flight))
            models.append(ActivityModel(title: "SLC", subTitle: "Salt Lake City", activityType: ActivityType.flight))
        default:
            models.append(ActivityModel(title: "", subTitle: "", activityType: ActivityType.excursion))
        }
        return models
    }
}
