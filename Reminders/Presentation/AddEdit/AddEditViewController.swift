//
//  AddEditViewController.swift
//  Reminders
//
//  Created by 쌩 on 7/3/24.
//

import UIKit

import RealmSwift

class AddEditViewController: UIViewController {
    
    private let addEditView = AddEditView()
    private var list: Results<Reminder>!
    private let realm = try! Realm()
    
    override func loadView() {
        view = addEditView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        let payment = Reminder(title: "test", priority: 0, content: "i'm test", tag: "스파이시", deadLine: Date(), imagePath: nil)
        do {
            try realm.write({
                realm.add(payment)
                print("Realm Create Succeed")
                self.list = realm.objects(Reminder.self)
            })
        } catch {
            print("data 생성에 error가 발생하였습니다..")
        }
    }
}

extension AddEditViewController {
    private func configureView() {
        self.addEditView.tableView.dataSource = self
        self.addEditView.tableView.delegate = self
        navigationItem.title = "새로운 할 일"
    }
}

extension AddEditViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK:  Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    // MARK:  Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else { return 1}
    }
    // MARK:  cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddEditTableViewCell.id, for: indexPath) as? AddEditTableViewCell else { return UITableViewCell() }
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "마감일"
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
}
