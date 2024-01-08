import UIKit

final class ActivityHeader: UITableViewHeaderFooterView {
    private let titleLabel: UILabel = {
        $0.font = UIFont(name: Theme.bodyFontNameBold, size: 17)
        return $0
    }(UILabel())

    private let subTitleLabel: UILabel = {
        $0.font = UIFont(name: Theme.bodyFontName, size: 15)
        $0.textAlignment = .right
        return $0
    }(UILabel())

    private let stackView: UIStackView = {
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupContstraints()
    }

    func configure(with day: DayModel) {
        titleLabel.text = day.title.mediumDate
        subTitleLabel.text = day.subtitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let view = UIView()
        view.backgroundColor = .systemGray2.withAlphaComponent(0.4)
        backgroundView = view
        addSubview(stackView)
        [titleLabel, subTitleLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }

    private func setupContstraints() {
        let padding = 20.0
        let spacing = 10.0
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spacing),
        ])
    }
}
