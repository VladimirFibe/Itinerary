import UIKit

final class ActivityHeader: UIView {
    private let titleLabel: UILabel = {
        return $0
    }(UILabel())

    private let subTitleLabel: UILabel = {
        return $0
    }(UILabel())

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
        [titleLabel, subTitleLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setupContstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            subTitleLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
