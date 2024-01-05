import UIKit

final class ActivityHeader: UIView {
    private let titleLabel: UILabel = {
        return $0
    }(UILabel())

    private let subTitleLabel: UILabel = {
        $0.textAlignment = .right
        return $0
    }(UILabel())

    private let stackView: UIStackView = {
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContstraints()
    }

    func configure(with title: String, subTitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(stackView)
        [titleLabel, subTitleLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }

    private func setupContstraints() {
        let padding = 20.0
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
