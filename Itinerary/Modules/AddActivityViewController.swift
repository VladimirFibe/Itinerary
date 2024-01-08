import UIKit

final class AddActivityViewController: PopupViewController {
    var trip: TripModel
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
}
// MARK: - Setup Views
extension AddActivityViewController {
    override func setupViews() {
        super.setupViews()
        bodyStackView.addArrangedSubview(daysPickerView)
        bodyStackView.addArrangedSubview(titleTextField)
        bodyStackView.addArrangedSubview(subTitleTextField)
        titleLabel.text = "Add Activity"
        daysPickerView.dataSource = self
        daysPickerView.delegate = self
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
