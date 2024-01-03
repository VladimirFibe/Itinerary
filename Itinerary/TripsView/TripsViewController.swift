import UIKit

final class TripsViewController: UIViewController {
    private let tableView = UITableView()

    private let addButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(Theme.actionButtonImage, for: [])
        $0.createFloatingActionButton()
        return $0
    }(UIButton(type: .system))

    private var trips: [TripModel] = [] {
        didSet { tableView.reloadData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        TripFunctions.read { [weak self] in
            self?.trips = Data.trips
        }
    }

    @objc private func addButtonHandle() {
        let controller = AddTripViewController()
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        controller.doneSaving = { [weak self] in self?.trips = Data.trips }
        present(controller, animated: true)
    }

    private func setupViews() {
        setupTableView()
        view.backgroundColor = Theme.background
        view.addSubview(addButton)
        addButton.addTarget(
            self,
            action: #selector(addButtonHandle),
            for: .primaryActionTriggered
        )
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            TripCell.self,
            forCellReuseIdentifier: TripCell.identifier
        )
        tableView.separatorStyle = .none
        tableView.dataSource = self
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            addButton.widthAnchor.constraint(equalToConstant: 56),
            addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

}
// MARK: - UITableViewDataSource
extension TripsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trips.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TripCell.identifier,
            for: indexPath
        ) as? TripCell else { fatalError() }
        cell.configure(with: trips[indexPath.row])
        return cell
    }
}
