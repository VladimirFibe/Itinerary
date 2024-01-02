import UIKit

final class TripsViewController: UITableViewController {
    private var trips: [TripModel] = [] {
        didSet { tableView.reloadData() }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(
            TripCell.self,
            forCellReuseIdentifier: TripCell.identifier
        )
        tableView.separatorStyle = .none
        TripFunctions.read { [weak self] in
            self?.trips = Data.trips
        }
    }

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
