import UIKit
import Photos
import PhotosUI

final class AddTripViewController: PopupViewController {
    var trip: TripModel?

    private let photoButton: UIButton = {
        $0.setImage(Theme.photoButtonImage, for: [])
        return $0
    }(UIButton(type: .system))

    @objc private func addPhoto() {
        presentPhotoPicker()
    }

    override func save() {
        titleTextField.rightViewMode = .never
        guard let title = titleTextField.text, !title.isEmpty else {
            let imageView = UIImageView(image: UIImage(systemName: "exclamationmark.triangle.fill"))
            imageView.tintColor = .red
            imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
            imageView.contentMode = .scaleAspectFit
            titleTextField.rightView =  imageView
            titleTextField.rightViewMode = .always
            titleTextField.layer.borderColor = UIColor.red.cgColor
            titleTextField.layer.borderWidth = 1
            return
        }
        if var trip {
            trip.image = cardView.image
            trip.title = title
            TripFunctions.update(trip)
        } else {
            TripFunctions.create(.init(title: title, image: cardView.image))
        }
        doneSaving?()
        dismiss(animated: true)
    }
}
// MARK: - Setup Views
extension AddTripViewController {
    override func setupViews() {
        super.setupViews()
        titleStackView.addArrangedSubview(photoButton)
        photoButton.addTarget(self, action: #selector(addPhoto), for: .primaryActionTriggered)
        if let trip {
            titleTextField.text = trip.title
            cardView.configure(with: trip.image)
            titleLabel.text = "Edit Trip"
        }
    }
}
// MARK: - PHPickerViewControllerDelegate
extension AddTripViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController,
                didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard let result = results.first else { return }
        result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
            guard let image = reading as? UIImage, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.cardView.configure(with: image)
            }
        }
    }

    func presentPhotoPicker() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
}
