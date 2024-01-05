import UIKit

final class ActivitiesViewController: UIViewController {
    var tripId: UUID
    var days: [DayModel] = [] {
        didSet { tableView.reloadData()}
    }
    private let backgroundImageView: UIImageView = {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())

    private let tableView: UITableView = {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.register(
            ActivityHeader.self,
            forHeaderFooterViewReuseIdentifier: ActivityHeader.identifier
        )
        $0.register(
            ActivityCell.self,
            forCellReuseIdentifier: ActivityCell.identifier
        )
        return $0
    }(UITableView())

    init(tripId: UUID) {
        self.tripId = tripId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        TripFunctions.readTrip(id: tripId) {[weak self] trip in
            guard let self, let trip else { return }
            self.backgroundImageView.image = trip.image
            self.days = trip.days
        }
    }

    private func setupView() {
        [backgroundImageView, tableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ActivitiesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        days.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        days[section].activityModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ActivityCell.identifier,
            for: indexPath
        ) as? ActivityCell else { fatalError()}
        cell.configure(with: days[indexPath.section].activityModels[indexPath.row])
        return cell
    }
}

extension ActivitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ActivityHeader.identifier) as? ActivityHeader else { return nil }
        header.configure(with: days[section])
        return header
    }
}
