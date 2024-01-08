import UIKit

final class ActivitiesViewController: UIViewController {
    var trip: TripModel

    private let addButton: UIButton = {
        $0.setImage(Theme.actionButtonImage, for: [])
        $0.createFloatingActionButton()
        return $0
    }(UIButton(type: .system))

    private let backgroundImageView: UIImageView = {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())

    private let tableView: UITableView = {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 70))
        $0.tableFooterView = footer
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

    init(trip: TripModel) {
        self.trip = trip
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        getDays()
    }

    func getDays() {
        backgroundImageView.image = trip.image
        tableView.reloadData()
    }

    private func setupView() {
        [backgroundImageView, tableView, addButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        tableView.dataSource = self
        tableView.delegate = self
        addButton.addTarget(
            self,
            action: #selector(addButtonHandler),
            for: .primaryActionTriggered
        )
    }

    @objc func addButtonHandler(_ sender: UIButton) {
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        let dayAction = UIAlertAction(
            title: "Day",
            style: .default,
            handler: handleAddDay
        )
        let activityAction = UIAlertAction(
            title: "Activity",
            style: .default,
            handler: handleAddActivity
        )
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel
        )
        alert.addAction(dayAction)
        alert.addAction(activityAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = sender
        alert.popoverPresentationController?.sourceRect = CGRect(
            x: 0,
            y: -sender.bounds.height / 2,
            width: sender.bounds.width,
            height: sender.bounds.height
        )
        present(alert, animated: true)
    }

    private func handleAddDay(action: UIAlertAction) {
        let controller = AddDayViewController(trip: trip)
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        controller.getDay = {[weak self] day in
            guard let self else { return }
            self.trip.days.append(day)
            let index = self.trip.days.firstIndex(of: day) ?? 0
            let indexSet = IndexSet([index])
            self.tableView.insertSections(indexSet, with: .automatic)
        }
        self.present(controller, animated: true)
    }

    private func handleAddActivity(action: UIAlertAction) {
        let controller = AddActivityViewController()
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        controller.doneSaving = {
            print("Save activity")
        }
        self.present(controller, animated: true)
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            addButton.widthAnchor.constraint(equalToConstant: 56),
            addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

extension ActivitiesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        trip.days.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trip.days[section].activityModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ActivityCell.identifier,
            for: indexPath
        ) as? ActivityCell else { fatalError()}
        cell.configure(with: trip.days[indexPath.section].activityModels[indexPath.row])
        return cell
    }
}

extension ActivitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ActivityHeader.identifier) as? ActivityHeader else { return nil }
        header.configure(with: trip.days[section])
        return header
    }
}
