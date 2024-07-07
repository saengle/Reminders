//
//  ListViewController.swift
//  Reminders
//
//  Created by 쌩 on 7/3/24.
//

import UIKit

class ListViewController: UIViewController {
    let realmDBHelper = RealmDBHelper()
    lazy var myList =  realmDBHelper.realm.objects(Reminder.self)
    let listView = ListView()
    override func loadView() {
        view = listView
    }
    lazy var imageWitdh = view.window?.windowScene?.screen.bounds.width
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
}
extension ListViewController {
    private func configureViewController() {
        listView.configureView(title: "All")
        listView.tableView.dataSource = self
        listView.tableView.delegate = self
        listView.tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
        listView.tableView.rowHeight = UITableView.automaticDimension
        print(myList)
    }
    
    private func makePriorityString(priority: Int) -> String? {
        var res: String?
        switch priority {
        case 0:
            res = nil
        case 1:
            res = "!"
        case 2:
            res = "!!"
        case 3:
            res = "!!!"
        default:
            res = nil
        }
        return res
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        let data = myList[indexPath.row]
        if let imageWitdh {
            cell.configureCell(title: data.title, content: data.content, priority: makePriorityString(priority: data.priority), date: "\(data.deadLine)", tag: data.tag, width: imageWitdh)
        }
        return cell
    }
    // MARK: cell swipe
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let detail = UIContextualAction(style: .normal, title: "detail") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            success(true)
        }
        detail.backgroundColor = .systemGray
        let flag = UIContextualAction(style: .normal, title: "Share") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            success(true)
        }
        flag.backgroundColor = .systemOrange
        let delete = UIContextualAction(style: .normal, title: "delete") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            self.realmDBHelper.deleteReminder(num: indexPath.row) {
                tableView.reloadData()
            }
            success(true)
        }
        delete.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions:[delete, flag, detail])
    }
}
