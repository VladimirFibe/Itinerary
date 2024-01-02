import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .red
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()
        TripFunctions.read {
            Data.trips.forEach { print($0.title ?? "")}
        }
        return true
    }
}

