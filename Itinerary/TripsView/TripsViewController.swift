import UIKit

final class TripsViewController: UITableViewController {
    private var trips: [TripModel] = [] {
        didSet { tableView.reloadData() }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        TripFunctions.read { [weak self] in
            self?.trips = Data.trips
        }
    }
    
    private func setupTableView() {
        tableView.register(
            TripCell.self,
            forCellReuseIdentifier: TripCell.identifier
        )
        tableView.separatorStyle = .none
    }

}
// MARK: - UITableViewDataSource
extension TripsViewController {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        trips.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TripCell.identifier,
            for: indexPath
        ) as? TripCell else { fatalError() }
        cell.configure(with: trips[indexPath.row])
        return cell
    }
}
