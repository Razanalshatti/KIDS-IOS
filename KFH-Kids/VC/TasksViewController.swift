////
////  TaskViewController.swift
////  KFH-Kids
////
////  Created by Razan alshatti on 22/05/2024.
////
//import UIKit
//
//class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//
//    let tableView = UITableView()
//    var tasks: [Task] = []
//    var totalPoints: Int = 0
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        title = "Assigned Tasks"
//        
//        setupTableView()
//        loadTasks()
//    }
//    
//    func setupTableView() {
//        view.addSubview(tableView)
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
//        
//        tableView.snp.makeConstraints { make in
//            make.edges.equalTo(view)
//        }
//    }
//    
//    func loadTasks() {
//        // Load your tasks data here
//        // This is just a sample. Replace it with your actual data loading logic.
//        tasks = [
//            Task(description: "Clean your room", points: 10, dueDate: Date(), isDone: false),
//            Task(description: "Do homework", points: 20, dueDate: Date().addingTimeInterval(-86400), isDone: false),
//            Task(description: "Wash dishes", points: 5, dueDate: Date().addingTimeInterval(-172800), isDone: true)
//        ]
//        tableView.reloadData()
//    }
//
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let sectionTasks = tasksForSection(section)
//        return sectionTasks.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
//        let task = tasksForSection(indexPath.section)[indexPath.row]
//        cell.configure(with: task)
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section {
//        case 0: return "Today"
//        case 1: return "Past"
//        case 2: return "Done"
//        default: return nil
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var task = tasksForSection(indexPath.section)[indexPath.row]
//        if !task.isDone && indexPath.section != 2 {
//            task.isDone = true
//            totalPoints += task.points
//            // Update the task in the original tasks array
//            if let index = tasks.firstIndex(where: { $0.description == task.description }) {
//                tasks[index].isDone = true
//            }
//            tableView.reloadData()
//        }
//    }
//    
//    func tasksForSection(_ section: Int) -> [Task] {
//        let now = Date()
//        switch section {
//        case 0:
//            return tasks.filter { !$0.isDone && Calendar.current.isDateInToday($0.dueDate) }
//        case 1:
//            return tasks.filter { !$0.isDone && $0.dueDate < now && !Calendar.current.isDateInToday($0.dueDate) }
//        case 2:
//            return tasks.filter { $0.isDone }
//        default:
//            return []
//        }
//    }
//}


import UIKit
import SnapKit

class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()
    var tasks: [Task] = []
    var totalPoints: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Assigned Tasks"
        
        setupTableView()
        loadTasks()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    func loadTasks() {
        // Load your tasks data here
        // This is just a sample. Replace it with your actual data loading logic.
        tasks = [
            Task(id: 1, ParentId: 101, taskType: "Chore", description: "Clean your room", date: Date(), points: 10, children: "Child1", dueDate: Date(), isDone: false),
            Task(id: 2, ParentId: 102, taskType: "Homework", description: "Do homework", date: Date().addingTimeInterval(-86400), points: 20, children: "Child2", dueDate: Date().addingTimeInterval(-86400), isDone: false),
            Task(id: 3, ParentId: 103, taskType: "Chore", description: "Wash dishes", date: Date().addingTimeInterval(-172800), points: 5, children: "Child3", dueDate: Date().addingTimeInterval(-172800), isDone: true)
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
            task.isDone.toggle()
            if task.isDone {
                self.totalPoints += task.points
            } else {
                self.totalPoints -= task.points
            }
            if let index = self.tasks.firstIndex(where: { $0.id == task.id }) {
                self.tasks[index].isDone = task.isDone
            }
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
    
    func tasksForSection(_ section: Int) -> [Task] {
        let now = Date()
        switch section {
        case 0:
            return tasks.filter { !$0.isDone && Calendar.current.isDateInToday($0.dueDate) }
        case 1:
            return tasks.filter { !$0.isDone && $0.dueDate < now && !Calendar.current.isDateInToday($0.dueDate) }
        case 2:
            return tasks.filter { $0.isDone }
        default:
            return []
        }
    }
}
