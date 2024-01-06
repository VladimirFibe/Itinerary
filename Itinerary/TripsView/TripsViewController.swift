import UIKit
import SwiftData

final class TripsViewController: UIViewController {
    enum Section { case main }
    var dataSource: UITableViewDiffableDataSource<Section, TripModel>!
    var container: ModelContainer?
    private let tableView = UITableView()
    private let helpView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        return blurredEffectView
    }()
    let seenHelpView = "seenHelpView"
    private var trips: [TripModel] = [] {
        didSet { updateData() }
    }
    
    private let addButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(Theme.actionButtonImage, for: [])
        $0.createFloatingActionButton()
        return $0
    }(UIButton(type: .system))
    
    private let helpContentView = TripHelpView()

    private let closeButton: TripButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Close", for: [])
        return $0
    }(TripButton(type: .system))

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        TripFunctions.readTrips { [weak self] trips in
            guard let self else { return }
            self.trips = trips
            if trips.count > 0 {
                if UserDefaults.standard.bool(forKey: self.seenHelpView) == false {
                    self.view.addSubview(self.helpView)
                    self.helpView.frame = self.view.bounds
                }
            }
        }
    }

    private func presentPopupViewController() {
        let controller = AddDayViewController()
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        controller.doneSaving = {
            print("Save")
        }
        self.present(controller, animated: true)
    }

    @objc private func addButtonHandle() {
        updateTrip()
//        presentPopupViewController()
    }

    @objc private func closeHelpView() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.helpView.alpha = 0
        } completion: { [weak self] success in
            guard let self else { return }
            self.helpView.removeFromSuperview()
            UserDefaults.standard.set(true, forKey: self.seenHelpView)
        }
    }

    private func setupViews() {
        setupTableView()
        navigationItem.title = "Trips"
        view.backgroundColor = Theme.background
        view.addSubview(addButton)

        helpView.contentView.addSubview(helpContentView)
        helpView.contentView.addSubview(closeButton)

        closeButton.addTarget(
            self,
            action: #selector(closeHelpView),
            for: .primaryActionTriggered
        )

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
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),

            helpContentView.topAnchor.constraint(equalTo: helpView.topAnchor, constant: 50),
            helpContentView.leadingAnchor.constraint(equalTo: helpView.leadingAnchor, constant: 18),
            helpContentView.trailingAnchor.constraint(equalTo: helpView.trailingAnchor, constant: -18),
            closeButton.centerXAnchor.constraint(equalTo: helpView.centerXAnchor),
            closeButton.bottomAnchor.constraint(equalTo: helpView.bottomAnchor, constant: -100),
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            closeButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

}
// MARK: - UITableViewDelegate
extension TripsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ActivitiesViewController(tripId: trips[indexPath.row].id)
        controller.navigationItem.title = trips[indexPath.row].title
        navigationController?.pushViewController(controller, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") {
            [weak self] action,
            view,
            actionPerformed in
            guard let self else {
                actionPerformed(false)
                return
            }
            let title = trips[indexPath.row].title
            let alert = UIAlertController(
                title: "Delete Trip",
                message: "Are you sure you want to delete this trip \(title)?",
                preferredStyle: .alert
            )
            alert.addAction(
                UIAlertAction(title: "Cancel",
                              style: .cancel,
                              handler: { _ in actionPerformed( false ) })
            )
            alert.addAction(UIAlertAction(title: "Delete", 
                                          style: .destructive,
                                          handler: { _ in
                TripFunctions.delete(self.trips[indexPath.row])
                self.trips = Data.trips
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
            self?.trips = Data.trips
        }
        self.present(controller, animated: true)
    }
}
