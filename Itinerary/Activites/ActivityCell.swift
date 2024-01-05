import UIKit

final class ActivityCell: UITableViewCell {
    private let cardView: UIImageView = {
        $0.backgroundColor = Theme.accent
        $0.addShadowAndRoundedCorners()
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    private let activityImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
        return $0
    }(UIImageView())

    private let titleLabel: UILabel = {
        $0.font = UIFont(name: Theme.bodyFontNameDemiBold, size: 17)
        $0.textAlignment = .left
        $0.textColor = .white
        return $0
    }(UILabel())

    private let subTitleLabel: UILabel = {
        $0.font = UIFont(name: Theme.bodyFontName, size: 17)
        $0.textAlignment = .left
        $0.textColor = .white
        return $0
    }(UILabel())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with activity: ActivityModel) {
        titleLabel.text = activity.title
        subTitleLabel.text = activity.subTitle
        activityImageView.image = activity.activityType.image
    }

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(cardView)
        [activityImageView, titleLabel, subTitleLabel].forEach {
            cardView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setupConstraints() {
        let padding = 12.0
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),

            activityImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: padding),
            activityImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: padding),
            activityImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -padding),
            activityImageView.widthAnchor.constraint(equalToConstant: 54),
            activityImageView.heightAnchor.constraint(equalTo: activityImageView.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: activityImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: activityImageView.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),

            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
}
