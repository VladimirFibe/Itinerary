import UIKit

final class AddDayViewController: PopupViewController {
    let subTitleTextField: UITextField = {
        $0.placeholder = "Subtitle name"
        $0.borderStyle = .roundedRect
        return $0
    }(UITextField())

}

extension AddDayViewController {
    override func setupViews() {
        super.setupViews()
        bodyStackView.addArrangedSubview(subTitleTextField)
    }
}
