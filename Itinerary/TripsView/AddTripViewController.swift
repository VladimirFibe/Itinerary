import UIKit

final class AddTripViewController: UIViewController {
    var doneSaving: (() -> ())?

    private let cardView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(PopupView())

    private let titleLabel: UILabel = {
        $0.text = "Add Trip"
        $0.font = UIFont(name: Theme.mainFontName, size: 24)
        $0.textColor = Theme.accent
        return $0
    }(UILabel())

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
        TripFunctions.create(.init(title: title))
        doneSaving?()
        dismiss(animated: true)
    }

    private func setupViews() {
        cancelButton.addTarget(self, action: #selector(cancel), for: .primaryActionTriggered)
        saveButton.addTarget(self, action: #selector(save), for: .primaryActionTriggered)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.addSubview(cardView)
        [titleLabel, tripTextField, cancelButton, saveButton].forEach {
            cardView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setupConstraints() {
        let padding = 20.0
        let spacing = 10.0

        NSLayoutConstraint.activate([
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),

            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -padding),

            tripTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            tripTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            tripTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            tripTextField.heightAnchor.constraint(equalToConstant: 44),
            cancelButton.topAnchor.constraint(equalTo: tripTextField.bottomAnchor, constant: spacing),
            cancelButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: 44),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),

            saveButton.topAnchor.constraint(equalTo: cancelButton.topAnchor),
            saveButton.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor),
            saveButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            saveButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor),

            cardView.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: padding)
        ])
    }
}
