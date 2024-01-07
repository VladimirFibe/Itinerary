import UIKit

final class AddDayViewController: PopupViewController {
    var getDay: ((DayModel) -> ())?
    var tripId: UUID?

    let datePicker: UIDatePicker = {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        return $0
    }(UIDatePicker())
    let subTitleTextField: UITextField = {
        $0.placeholder = "Description (optional)"
        $0.borderStyle = .roundedRect
        $0.returnKeyType = .done
        return $0
    }(UITextField())
}
// MARK: - Actions
extension AddDayViewController {
    override func save() {
        guard let tripId else { return }
        let subtitle = subTitleTextField.text ?? ""
        let title = datePicker.date
        let day = DayModel(title: title, subtitle: subtitle, data: nil)
        DayFunctions.createDays(at: tripId, using: day)
        getDay?(day)
        dismiss(animated: true)
    }

    @objc func done(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}
// MARK: - Setup Views
extension AddDayViewController {
    override func setupViews() {
        super.setupViews()
        bodyStackView.addArrangedSubview(datePicker)
        bodyStackView.addArrangedSubview(subTitleTextField)
        titleLabel.text = "Add day"
        subTitleTextField.addTarget(self, action: #selector(done), for: .primaryActionTriggered)
    }
}
