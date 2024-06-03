import UIKit
import SnapKit

class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()
    var tasks: [MyTask] = []
    var child: TokenResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Tasks"

        setupTableView()
        loadTasks()
//        fetchTasks(childId: Int)
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        tableView.rowHeight = 80  // Adjusted row height

        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }

    func loadTasks() {
        tasks = [
            MyTask(Id: 1, ParentId: 101, TaskType: "Clean", Description: "Room", Date: Date(), Points: 10, childId: 1, dueDate: Date().addingTimeInterval(-86400), isCompleted: false, Parent: Parent.init(ParentId: 101, Username: "aseel", Password: "1234", Email: "A@gmail.com", PhoneNumber: "94010640", children: "razan")),
            MyTask(Id: 1, ParentId: 102, TaskType: "HW", Description: "Math", Date: Date(), Points: 10, childId: 2, dueDate: Date().addingTimeInterval(-86400), isCompleted: true, Parent: Parent.init(ParentId: 102, Username: "nada", Password: "1234", Email: "N@gmail.com", PhoneNumber: "94999428", children: "aseel")),
            MyTask(Id: 1, ParentId: 103, TaskType: "Play", Description: "Park", Date: Date(), Points: 10, childId: 1, dueDate: Date().addingTimeInterval(-86400), isCompleted: false, Parent: Parent.init(ParentId: 103, Username: "fatma", Password: "1234", Email: "F@gmail.com", PhoneNumber: "94010640", children: "razan"))
        ]
        tableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
            self.tableView.reloadData()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Today"
        case 1: return "Past"
        case 2: return "Done"
        default: return nil
        }
    }

    func tasksForSection(_ section: Int) -> [MyTask] {
        let now = Date()
        switch section {
        case 0:
            return tasks.filter { !$0.isCompleted && Calendar.current.isDateInToday($0.dueDate) }
        case 1:
            return tasks.filter { !$0.isCompleted && $0.dueDate < now && !Calendar.current.isDateInToday($0.dueDate) }
        case 2:
            return tasks.filter { $0.isCompleted }
        default:
            return []
        }
    }
    
    func fetchTasks(childId: Int) {
        
        NetworkManager.shared.GetTasks(childId: childId) { result in
            switch result {
            case .success(let tokenResponse):
                
                print("Success \(tokenResponse.count)")
                DispatchQueue.main.async {

                    self.tasks = tokenResponse

                }
            case .failure(let error):
                
                print("Failed! \(error.localizedDescription)")
                DispatchQueue.main.async {
                }
            }
            
        }
        
    }
    
}
