import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = UINavigationController(rootViewController: TripsViewController())
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        setupAppearance()
        return true
    }

    func setupAppearance() {
        let appearance = UINavigationBarAppearance()
        let buttonAppearance = UIBarButtonItemAppearance(style: .plain)
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Theme.accent

        let font = UIFont(name: Theme.mainFontName, size: 20) ?? .boldSystemFont(ofSize: 20)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: font
        ]

        buttonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: font
        ]
        appearance.buttonAppearance = buttonAppearance

        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

