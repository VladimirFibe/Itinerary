import UIKit

final class TripButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        tintColor = Theme.background
        backgroundColor = Theme.tint
        layer.cornerRadius = 22
    }
}
