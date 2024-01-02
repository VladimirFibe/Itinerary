import UIKit

final class TripCell: UITableViewCell {
    static let identifier = "TripCell"
    
    private let cardView: UIView = {
        $0.backgroundColor = .darkGray
        $0.layer.cornerRadius = 10
        $0.layer.shadowOpacity = 1
        $0.layer.shadowOffset = .zero
        $0.layer.shadowColor = UIColor.darkGray.cgColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    private let titleLabel: UILabel = {
        $0.font = UIFont.preferredFont(forTextStyle: .largeTitle)
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
    }

    private func setupViews() {
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
