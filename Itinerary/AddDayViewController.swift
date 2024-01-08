import UIKit

final class AddDayViewController: PopupViewController {
    var getDay: ((DayModel) -> ())?
    var trip: TripModel
    init(trip: TripModel) {
        self.trip = trip
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        if alreadyExists {
            let alert = UIAlertController(
                title: "Day Already Exists",
                message: "Choose another date",
                preferredStyle: .alert
            )
            let ok = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(ok)
            present(alert, animated: true)
            return
        }
        let subtitle = subTitleTextField.text ?? ""
        let title = datePicker.date
        let day = DayModel(title: title, subtitle: subtitle, data: nil)
        DayFunctions.createDays(at: trip.id, using: day)
        getDay?(day)
        dismiss(animated: true)
    }

    var alreadyExists: Bool {
        let date = datePicker.date
        return trip.days.contains(where: {$0.title.mediumDate == date.mediumDate})
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
