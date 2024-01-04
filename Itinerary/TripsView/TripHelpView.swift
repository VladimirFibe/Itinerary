import UIKit

final class TripHelpView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        let title = UILabel()
        title.text = "Swipe rows for more features!"
        title.font = .systemFont(ofSize: 30)
        title.textColor = .white
        title.numberOfLines = 2
        title.textAlignment = .center
        let deleteView = UIImageView(image: .deleteSwipe)
        deleteView.contentMode = .scaleAspectFit
        let editView = UIImageView(image: .editSwipe)
        editView.contentMode = .scaleAspectFit
        let stackView = UIStackView(arrangedSubviews: [title, deleteView, editView])
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            deleteView.heightAnchor.constraint(equalToConstant: 150),
            editView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}
