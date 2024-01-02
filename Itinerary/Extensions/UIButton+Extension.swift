import UIKit

extension UIButton {
    func createFloatingActionButton(radius: CGFloat = 28) {
        tintColor = Theme.background
        backgroundColor = Theme.tint
        layer.cornerRadius = radius
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }
}
