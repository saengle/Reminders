//
//  AddEditViewController.swift
//  Reminders
//
//  Created by 쌩 on 7/3/24.
//

import UIKit

import RealmSwift

class AddEditViewController: UIViewController{
    
    private let addEditView = AddEditView()
    private var list: Results<Reminder>!
    private let realm = try! Realm()
    
    lazy var navBarItemCancel = {
        let bt = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(barButtonClicked(_:)))
        bt.tag = 0
        return bt
    }()
    
    lazy var navBarItemAdd = {
        let bt = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(barButtonClicked(_:)))
        bt.tag = 1
        return bt
    }()
    
    
    override func loadView() {
        view = addEditView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavBar()
        let payment = Reminder(title: "test", priority: 0, content: "i'm test", tag: "스파이시", deadLine: Date(), imagePath: nil, isDone: false)
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
    @objc func barButtonClicked(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 0:
            print("캔슬버튼 클릭됨")
        case 1:
            print("애드버튼 클릭됨")
        default:
            print("error")
        }
    }
    
    private func configureNavBar() {
        self.navigationItem.rightBarButtonItem = self.navBarItemAdd
        self.navigationItem.leftBarButtonItem = self.navBarItemCancel
        self.navigationItem.title = "새로운 할 일"
    }
    
    private func configureView() {
        self.addEditView.tableView.dataSource = self
        self.addEditView.tableView.delegate = self
        if #available(iOS 15.0, *) {
            self.addEditView.tableView.sectionFooterHeight = 0
        }
    }
}

extension AddEditViewController: UITextFieldDelegate{
    
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
            cell.backgroundColor = .tertiarySystemBackground
            switch indexPath.row {
            case 0:
                cell.configureCell(placeholer: "제목")
                cell.textField.delegate = self
            case 1:
                cell.configureCell(placeholer: "내용")
                cell.textField.delegate = self
            default:
                print("")
            }
            return cell
        } else {
            let cell = UITableViewCell()
            cell.backgroundColor = .tertiarySystemBackground
            switch indexPath.section {
            case 1:
                cell.textLabel?.text = "마감일"
            case 2:
                cell.textLabel?.text = "태그"
            case 3:
                cell.textLabel?.text = "우선 순위"
            case 4:
                cell.textLabel?.text = "이미지 추가"
            default:
                print("")
            }
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        switch indexPath.section {
        //        case 1:
        //
        //        case 2:
        //
        //        case 3:
        //
        //        case 4:
        //
        //        default:
        //            print("")
        //        }
    }
}
