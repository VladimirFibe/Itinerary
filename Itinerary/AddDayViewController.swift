import UIKit

final class AddDayViewController: PopupViewController {
    let subTitleTextField: UITextField = {
        $0.placeholder = "Description (optional)"
        $0.borderStyle = .roundedRect
        return $0
    }(UITextField())

}
// MARK: - Actions
extension AddDayViewController {
    
    override func save() {
        super.save()
        print(titleTextField.text ?? "")
        print(subTitleTextField.text ?? "")
    }
}
// MARK: - Setup Views
extension AddDayViewController {
    override func setupViews() {
        super.setupViews()
        bodyStackView.addArrangedSubview(subTitleTextField)
        titleLabel.text = "Add day"
        titleTextField.placeholder = "Title or date"
    }
}
