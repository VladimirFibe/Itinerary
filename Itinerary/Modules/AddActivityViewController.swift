import UIKit

final class AddActivityViewController: PopupViewController {
    var getActivity: ((Int, ActivityModel) -> ())?
    var trip: TripModel
    var selected = ActivityType.excursion {
        didSet { setupSelectedActivity()}
    }
    init(trip: TripModel) {
        self.trip = trip
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let daysPickerView: UIPickerView = {
        return $0
    }(UIPickerView())

    let titleTextField: UITextField = {
        $0.placeholder = "What are you doing?"
        return $0
    }(UITextField())

    let subTitleTextField: UITextField = {
        $0.placeholder = "Description (optional)"
        return $0
    }(UITextField())

    let activitiesStackView: UIStackView = {
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())

    var buttons: [ActivityButton] = []
}
// MARK: - Actions
extension AddActivityViewController {
    override func save() {
        guard titleTextField.hasValue, let title = titleTextField.text else { return }
        let dayIndex = daysPickerView.selectedRow(inComponent: 0)
        let subTitle = subTitleTextField.text ?? ""
        let activity = ActivityModel(title: title, subTitle: subTitle, activityType: selected)
        ActivityFunctions.createActivity(at: trip, for: dayIndex, using: activity)
        getActivity?(dayIndex, activity)
        dismiss(animated: true)
    }
}
// MARK: - Setup Views
extension AddActivityViewController {
    override func setupViews() {
        super.setupViews()
        bodyStackView.addArrangedSubview(daysPickerView)
        bodyStackView.addArrangedSubview(activitiesStackView)
        bodyStackView.addArrangedSubview(titleTextField)
        bodyStackView.addArrangedSubview(subTitleTextField)
        titleLabel.text = "Add Activity"
        daysPickerView.dataSource = self
        daysPickerView.delegate = self
        setupActivitiesPicker()
        setupSelectedActivity()
    }

    private func setupActivitiesPicker() {
        ActivityType.allCases.forEach {
            let button = ActivityButton(with: $0)
            button.addTarget(self, action: #selector(buttonHandler), for: .primaryActionTriggered)
            buttons.append(button)
            activitiesStackView.addArrangedSubview(button)
        }
    }

    @objc private func buttonHandler(_ sender: ActivityButton) {
        selected = sender.activity
    }

    private func setupSelectedActivity() {
        buttons.forEach {
            $0.tintColor = selected == $0.activity ? Theme.tint : Theme.accent
        }
    }
}
// MARK: - UIPickerViewDataSource
extension AddActivityViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        trip.days.count
    }
}
// MARK: -
extension AddActivityViewController: UIPickerViewDelegate {
    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        trip.days[row].title.mediumDate
    }
}
