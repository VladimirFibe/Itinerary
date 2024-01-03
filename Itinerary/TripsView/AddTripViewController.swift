import UIKit
import Photos
import PhotosUI

final class AddTripViewController: UIViewController {
    var doneSaving: (() -> ())?
    var trip: TripModel?

    private let cardView = PopupView()

    private let titleLabel: UILabel = {
        $0.layer.shadowOpacity = 1
        $0.layer.shadowColor = UIColor.white.cgColor
        $0.layer.shadowOffset = .zero
        $0.layer.shadowRadius = 5
        $0.text = "Add Trip"
        $0.font = UIFont(name: Theme.mainFontName, size: 24)
        $0.textColor = Theme.accent
        return $0
    }(UILabel())

    private let photoButton: UIButton = {
        $0.setImage(Theme.photoButtonImage, for: [])
        return $0
    }(UIButton(type: .system))

    private let tripTextField: UITextField = {
        $0.placeholder = "Trip name"
        $0.borderStyle = .roundedRect
        return $0
    }(UITextField())

    private let cancelButton: UIButton = {
        $0.setTitle("Cancel", for: [])
        return $0
    }(TripButton(type: .system))

    private let saveButton: UIButton = {
        $0.setTitle("Save", for: [])
        return $0
    }(TripButton(type: .system))

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    @objc private func addPhoto() {
        presentPhotoPicker()
    }

    @objc private func cancel() {
        dismiss(animated: true)
    }

    @objc private func save() {
        tripTextField.rightViewMode = .never
        guard let title = tripTextField.text, !title.isEmpty else {
            let imageView = UIImageView(image: UIImage(systemName: "exclamationmark.triangle.fill"))
            imageView.tintColor = .red
            imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
            imageView.contentMode = .scaleAspectFit
            tripTextField.rightView =  imageView
            tripTextField.rightViewMode = .always
            tripTextField.layer.borderColor = UIColor.red.cgColor
            tripTextField.layer.borderWidth = 1
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

    private func setupViews() {
        photoButton.addTarget(self, action: #selector(addPhoto), for: .primaryActionTriggered)
        cancelButton.addTarget(self, action: #selector(cancel), for: .primaryActionTriggered)
        saveButton.addTarget(self, action: #selector(save), for: .primaryActionTriggered)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        [
            cardView,
            titleLabel,
            photoButton,
            tripTextField,
            cancelButton,
            saveButton
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        if let trip {
            tripTextField.text = trip.title
            cardView.image = trip.image
        }
    }

    private func setupConstraints() {
        let padding = 20.0
        let spacing = 10.0

        NSLayoutConstraint.activate([
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            cardView.heightAnchor.constraint(equalToConstant: 200),

            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: padding),

            photoButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            photoButton.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            photoButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -padding),
            photoButton.widthAnchor.constraint(equalToConstant: 30),
            photoButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: spacing),

            tripTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            tripTextField.trailingAnchor.constraint(equalTo: photoButton.trailingAnchor),
            tripTextField.heightAnchor.constraint(equalToConstant: 44),
            cancelButton.topAnchor.constraint(equalTo: tripTextField.bottomAnchor, constant: spacing),
            cancelButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: 44),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),

            saveButton.topAnchor.constraint(equalTo: cancelButton.topAnchor),
            saveButton.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor),
            saveButton.trailingAnchor.constraint(equalTo: photoButton.trailingAnchor),
            saveButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor),

            cardView.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: padding)
        ])
    }
}

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
                self.cardView.image = image
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
