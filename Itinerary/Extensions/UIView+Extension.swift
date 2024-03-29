import UIKit

extension UIView {
    func addShadowAndRoundedCorners() {
        layer.cornerRadius = 10
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.masksToBounds = true
    }
}
