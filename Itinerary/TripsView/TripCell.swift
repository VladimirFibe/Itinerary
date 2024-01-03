import UIKit

final class TripCell: UITableViewCell {
    static let identifier = "TripCell"
    
    private let cardView: UIImageView = {
        $0.backgroundColor = Theme.accent
        $0.addShadowAndRoundedCorners()
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    private let titleLabel: UILabel = {
        $0.font = UIFont(name: Theme.mainFontName, size: 20)
        $0.textAlignment = .center
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
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

    func configure(with trip: TripModel) {
        titleLabel.text = trip.title
        cardView.image = trip.image
    }

    private func setupViews() {
        backgroundColor = .clear
        contentView.addSubview(cardView)
        cardView.addSubview(titleLabel)
    }

    private func setupConstraints() {
        let padding = 10.0
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),

            contentView.heightAnchor.constraint(equalToConstant: 160),

            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
        ])
    }
}
