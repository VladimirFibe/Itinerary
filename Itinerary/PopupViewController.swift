import UIKit

class PopupViewController: UIViewController {
    var doneSaving: (() -> ())?

    let cardView = PopupView()

    let cancelButton: TripButton = {
        $0.setTitle("Cancel", for: [])
        return $0
    }(TripButton(type: .system))

    let saveButton: TripButton = {
        $0.setTitle("Save", for: [])
        return $0
    }(TripButton(type: .system))

    let rootStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())

    let buttonsStackView: UIStackView = {
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

@objc extension PopupViewController {
    func setupViews() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.addSubview(cardView)
        cardView.addSubview(rootStackView)
        rootStackView.addArrangedSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(cancelButton)
        buttonsStackView.addArrangedSubview(saveButton)
        saveButton.addTarget(self, action: #selector(save), for: .primaryActionTriggered)
    }

    func setupConstraints() {
        let padding = 20.0

        NSLayoutConstraint.activate([
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),

            rootStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: padding),
            rootStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: padding),
            rootStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -padding),
            rootStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -padding)
        ])
    }

    func save() {
        dismiss(animated: true)
    }
}
