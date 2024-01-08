import UIKit

class PopupViewController: UIViewController {
    var doneSaving: (() -> ())?

    let cardView = PopupView()

    let titleLabel: UILabel = {
        $0.text = "Add Trip"
        $0.font = UIFont(name: Theme.mainFontName, size: 24)
        $0.textColor = Theme.accent
        return $0
    }(UILabel())

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
        $0.axis = .vertical
        $0.spacing = 20
        return $0
    }(UIStackView())

    let titleStackView: UIStackView = {
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())

    let bodyStackView: UIStackView = {
        $0.spacing = 10
        $0.axis = .vertical
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
        rootStackView.addArrangedSubview(titleStackView)
        rootStackView.addArrangedSubview(bodyStackView)
        rootStackView.addArrangedSubview(buttonsStackView)
        titleStackView.addArrangedSubview(titleLabel)
        buttonsStackView.addArrangedSubview(cancelButton)
        buttonsStackView.addArrangedSubview(saveButton)
        cancelButton.addTarget(self, action: #selector(cancel), for: .primaryActionTriggered)
        saveButton.addTarget(self, action: #selector(save), for: .primaryActionTriggered)
    }

    func setupConstraints() {
        let padding = 20.0

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),

            rootStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: padding),
            rootStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: padding),
            rootStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -padding),
            rootStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -padding)
        ])
    }

    func cancel() {
        dismiss(animated: true)
    }

    func save() {
        doneSaving?()
        dismiss(animated: true)
    }
}
