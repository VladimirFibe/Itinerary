import UIKit
import SwiftData

final class TripsViewController: UIViewController {
    enum Section { case main }
    var dataSource: UITableViewDiffableDataSource<Section, TripModel>!
    var container: ModelContainer?
    private let tableView = UITableView()
    private var trips: [TripModel] = [] {
        didSet { updateData() }
    }
    
    private let addButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(Theme.actionButtonImage, for: [])
        $0.createFloatingActionButton()
        return $0
    }(UIButton(type: .system))

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        TripFunctions.read { [weak self] trips in
            self?.trips = trips
        }
    }

    @objc private func addButtonHandle() {
        updateTrip()
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
        tableView.delegate = self
        dataSource = UITableViewDiffableDataSource<Section, TripModel>(tableView: tableView, cellProvider: { tableView, indexPath, trip in
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: TripCell.identifier,
                        for: indexPath
                    ) as? TripCell else { fatalError() }
                    cell.configure(with: trip)
                    return cell
        })
    }

    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, TripModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(trips)
        dataSource.apply(snapshot, animatingDifferences: true)
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
// MARK: - UITableViewDelegate
extension TripsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") {[weak self] action, view, actionPerformed in
            guard let self else {
                actionPerformed(false)
                return
            }
            let title = "Data.trips[indexPath.row].title"
            let alert = UIAlertController(title: "Delete Trip", message: "Are you sure you want to delete this trip \(title)?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                actionPerformed(false)
            }))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                TripFunctions.delete(self.trips[indexPath.row])
                self.trips = StorageManager.trips
                actionPerformed(true)
            }))
            self.present(alert, animated: true)
        }
        delete.image = Theme.deleteActionImage
        return UISwipeActionsConfiguration(actions: [delete])
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") { [weak self] action, view, actionPerformed in
            guard let self else { return }
            self.updateTrip(trips[indexPath.row])
            actionPerformed(true)
        }
        edit.image = Theme.editActionImage
        edit.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [edit])
    }

    func updateTrip(_ trip: TripModel? = nil) {
        let controller = AddTripViewController()
        controller.trip = trip
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        controller.doneSaving = { [weak self] in
            self?.trips = StorageManager.trips
        }
        self.present(controller, animated: true)
    }
}
