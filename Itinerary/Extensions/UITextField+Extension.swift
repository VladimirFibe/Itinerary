import UIKit

extension UITextField {
    var hasValue: Bool {
        guard text == "" else { return true }
        let imageView = UIImageView(image: UIImage(systemName: "exclamationmark.triangle.fill"))
        imageView.tintColor = .red
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.contentMode = .scaleAspectFit
        rightView =  imageView
        rightViewMode = .unlessEditing
        return false
    }
}
