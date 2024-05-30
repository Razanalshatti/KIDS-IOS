//
//  TaskViewController.swift
//  KFH-Kids
//
//  Created by Razan alshatti on 22/05/2024.
//


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
        tasks = [
            Task(Id: 1, ParentId: 1, TaskType: "Homework", Description: "Do your homework", Date: Date(), Points: 5, childId: 1, dueDate:  Date() , isCompleted: true, Parent: Parent(ParentId: 1, Username: "Razan", Password: "123", Email: "R@gmail.com", PhoneNumber: "94010640", children: "Wafaa"))
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
            if task.isCompleted {
                self.totalPoints += task.Points
            } else {
                self.totalPoints -= task.Points
            }
            if let index = self.tasks.firstIndex(where: { $0.Id == task.Id }) {
                self.tasks[index].isCompleted = task.isCompleted
            }
            self.tableView.reloadData()
        }

        return cell
    }

    func tableView( tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
            return tasks.filter { !$0.isCompleted && Calendar.current.isDateInToday($0.dueDate) }
        case 1:
            return tasks.filter { !$0.isCompleted && $0.dueDate < now && !Calendar.current.isDateInToday($0.dueDate) }
        case 2:
            return tasks.filter { $0.isCompleted }
        default:
            return []
        }
    }
    
}
