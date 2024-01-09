import UIKit

final class ActivityButton: UIButton {
    let activity: ActivityType
    init(with activity: ActivityType) {
        self.activity = activity
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        setImage(activity.image, for: [])
        heightAnchor.constraint(equalToConstant: 44).isActive = true
        widthAnchor.constraint(equalToConstant: 44).isActive = true
    }
}
