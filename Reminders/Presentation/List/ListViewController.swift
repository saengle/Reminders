//
//  ListViewController.swift
//  Reminders
//
//  Created by 쌩 on 7/3/24.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController {
    let realmDBHelper = RealmDBHelper()
    lazy var myList: [Reminder] = []{
        didSet {
            self.listView.tableView.reloadData()
        }
    }
    lazy var mainTitle = ""
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
        listView.configureView(title: mainTitle)
        listView.tableView.dataSource = self
        listView.tableView.delegate = self
        listView.tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
        listView.tableView.rowHeight = UITableView.automaticDimension
        myList = realmDBHelper.readFilterdReminders(filter: FilteringType.all)
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
    private func loadImage(id: String) -> UIImage? {
        if #available(iOS 16.0, *) {
            return loadImageToDocument(filename: "\(id)")
        } else {
            return nil
        }
    }
    private func makeDateFormatted(date: Date) -> String{
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy. MM. dd. E"
        myDateFormatter.locale = Locale(identifier:"ko_KR") 
        let convertStr = myDateFormatter.string(from: date)
        return convertStr
    }
}

@available(iOS 16.0, *)
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        let data = myList[indexPath.row]
        let tempImage = self.loadImage(id: "\(data.id)")
        if let imageWitdh {
            cell.configureCell(title: data.title, flag: data.flag, content: data.content, priority: makePriorityString(priority: data.priority), date: makeDateFormatted(date: data.deadLine), tag: data.tag, image: tempImage, width: imageWitdh)
            if tempImage == nil {
                cell.myImageView.isHidden = true
            }
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
            self.removeImageFromDocument(filename: "\(self.myList[indexPath.row].id)")
            self.realmDBHelper.deleteReminder(id: self.myList[indexPath.row].id) {
                self.myList = self.realmDBHelper.readFilterdReminders(filter: FilteringType.all)
            }
            success(true)
        }
        delete.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions:[delete, flag, detail])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        realmDBHelper.updateReminder(oldData: myList[indexPath.row], newData: Reminder(title: "테스트으", priority: 1, content: "좋겠다아아앙", tag: "라라라 ?", deadLine: Date(), imagePath: nil, isDone: false, flag: false)) {
            self.myList = self.realmDBHelper.readFilterdReminders(filter: FilteringType.all)
        }
    }
}
