import UIKit
import SnapKit

class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()
    let pointsBalanceLabel = UILabel()
    var tasks: [MyTask] = []
    var childPoints: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Tasks"

        setupTableView()
        setupPointsBalanceLabel()
        loadTasks()
        updatePointsBalance()
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        tableView.rowHeight = 80  // Adjusted row height

        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view).inset(UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0))
        }
    }

    func setupPointsBalanceLabel() {
        pointsBalanceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        pointsBalanceLabel.textColor = .black
        view.addSubview(pointsBalanceLabel)

        pointsBalanceLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(view)
        }
    }

    func loadTasks() {
        tasks = [
            MyTask(Id: 1, ParentId: 101, TaskType: "Clean Your Bedroom", Description: "Room", Date: Date(), Points: 10, childId: 1, dueDate: Date().addingTimeInterval(-86400), isCompleted: false, Parent: Parent.init(ParentId: 101, Username: "aseel", Password: "1234", Email: "A@gmail.com", PhoneNumber: "94010640", children: "razan")),
            MyTask(Id: 2, ParentId: 102, TaskType: "Do Your Homework", Description: "Math", Date: Date(), Points: 10, childId: 2, dueDate: Date().addingTimeInterval(-86400), isCompleted: false, Parent: Parent.init(ParentId: 102, Username: "nada", Password: "1234", Email: "N@gmail.com", PhoneNumber: "94999428", children: "aseel")),
            MyTask(Id: 3, ParentId: 103, TaskType: "Swimming Class and Gym Time", Description: "Park", Date: Date(), Points: 10, childId: 1, dueDate: Date().addingTimeInterval(-86400), isCompleted: false, Parent: Parent.init(ParentId: 103, Username: "fatma", Password: "1234", Email: "F@gmail.com", PhoneNumber: "94010640", children: "razan"))
        ]
        tableView.reloadData()
        updatePointsBalance()
    }

    func updatePointsBalance() {
        childPoints = tasks.filter { $0.isCompleted }.reduce(0) { $0 + $1.Points }
        pointsBalanceLabel.text = "Points: \(childPoints)"
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // Updated to have two sections: Todo and Done
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTasks = tasksForSection(section)
        return sectionTasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        let task = tasksForSection(indexPath.section)[indexPath.row]
        cell.configure(with: task)

        cell.checkboxAction = { [weak self] in
            guard let self = self else { return }
            var task = self.tasksForSection(indexPath.section)[indexPath.row]
            task.isCompleted.toggle()
            if let index = self.tasks.firstIndex(where: { $0.Id == task.Id }) {
                self.tasks[index] = task
            }
            self.updatePointsBalance()
            self.tableView.reloadData()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "To Do Tasks" // Updated section title
        case 1: return "Done Tasks" // Updated section title
        default: return nil
        }
    }

    func tasksForSection(_ section: Int) -> [MyTask] {
        switch section {
        case 0:
            return tasks.filter { !$0.isCompleted }
        case 1:
            return tasks.filter { $0.isCompleted }
        default:
            return []
        }
    }
}
