import UIKit

final class AddActivityViewController: PopupViewController {
    let datePicker: UIDatePicker = {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        return $0
    }(UIDatePicker())

}

extension AddActivityViewController {
    override func setupViews() {
        super.setupViews()
        bodyStackView.addArrangedSubview(datePicker)
        titleLabel.text = "Add Activity"
    }
}
