import UIKit
import SnapKit

class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    let pointsBalanceLabel = UILabel()
    var tasks: [MyTask] = []
    var childPoints: Int = 0
    var childId: Int = 1
    var taskId: Int = 1
    
    var child: TokenResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Tasks"
        
        setupTableView()
        setupPointsBalanceLabel()
        fetchTasks(childId: childId)
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
        tableView.reloadData()
    }
    
    func updatePointsBalance() {
        pointsBalanceLabel.text = "Points: \(child?.points ?? 0)"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTasks = tasksForSection(section)
        return sectionTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        var task = tasksForSection(indexPath.section)[indexPath.row]
        cell.configure(with: task)

        cell.checkboxAction = { [weak self] in
            guard let self = self else { return }
            let oldTaskStatus = task.isCompleted
            
            task.isCompleted.toggle()
            if let index = self.tasks.firstIndex(where: { $0.id == task.id }) {
                self.tasks[index] = task
            }
            if (task.isCompleted && oldTaskStatus == false) {
                self.completeTask(childId: self.childId, task: task)
                self.updatePointsBalance()
            }
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
    
    func fetchTasks(childId: Int) {
        NetworkManager.shared.GetTasks(childId: childId) { result in
            switch result {
            case .success(let tasks):
                DispatchQueue.main.async {
                    self.tasks = tasks
                    
                    self.tableView.reloadData()
                    self.updatePointsBalance()
                }
            case .failure(let error):
                print("Failed to fetch tasks: \(error.localizedDescription)")
            }
        }
    }
    
    func completeTask(childId: Int, task: MyTask) {
            NetworkManager.shared.taskCompletion(childId: childId, taskId: task.id) { result in
                switch result {
                case .success(let updatedTasks):
                    DispatchQueue.main.async {
                        self.updatePointsBalance()
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Failed to complete task: \(error.localizedDescription)")
                }
            }
    }
   

}
