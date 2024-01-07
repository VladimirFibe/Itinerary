import UIKit

final class AddDayViewController: PopupViewController {
    var getDay: ((DayModel) -> ())?
    var tripId: UUID?
    let subTitleTextField: UITextField = {
        $0.placeholder = "Description (optional)"
        $0.borderStyle = .roundedRect
        return $0
    }(UITextField())

}
// MARK: - Actions
extension AddDayViewController {
    override func save() {
        guard titleTextField.hasValue,
        let title = titleTextField.text,
        let tripId else { return }
        let subtitle = subTitleTextField.text ?? ""
        let day = DayModel(title: title, subtitle: subtitle, data: nil)
        DayFunctions.createDays(at: tripId, using: day)
        getDay?(day)
        dismiss(animated: true)
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
