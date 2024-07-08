//
//  AddEditViewController.swift
//  Reminders
//
//  Created by 쌩 on 7/3/24.
//

import UIKit
import PhotosUI

import RealmSwift

class AddEditViewController: UIViewController{
    
    private let realmDBHelper = RealmDBHelper()
    private let addEditView = AddEditView()
    
    var myReminder: Reminder?
    private var titleText: String = ""
    private var contentText: String?
    private var date = Date()
    private var priority = 0
    private var tag = ""
    private var image: UIImage?
    
    lazy var navBarItemCancel = {
        let bt = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(barButtonClicked(_:)))
        bt.tag = 0
        return bt
    }()
    
    lazy var navBarItemAdd = {
        let bt = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(barButtonClicked(_:)))
        bt.tag = 1
        bt.isEnabled = false
        return bt
    }()
    
    override func loadView() {
        view = addEditView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavBar()
        NotificationCenter.default.addObserver(self, selector: #selector(memoReceivedNotification), name: NSNotification.Name("memoReceived"), object: nil)
        let realm = try! Realm()
    }
}

extension AddEditViewController {
    
    @objc func memoReceivedNotification(notification: NSNotification) {
        if let result = notification.userInfo?["priority"] as? Int {
            priority = result
        }
        if let result = notification.userInfo?["tag"] as? String {
            tag = result
        }
        if let result = notification.userInfo?["date"] as? Date {
            date = result
        }
    }
    @objc func barButtonClicked(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 0: // cancelButtonClicked
            dismiss()
        case 1: // AddButtonClicked
            addReminder()
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
    private func addReminder() {
        let reminder = Reminder(title: self.titleText, priority: self.priority, content: self.contentText, tag: nil, deadLine: date, imagePath: nil, isDone: false, flag: false )
        realmDBHelper.createReminder(data: reminder)
        if let image = self.image {
            if #available(iOS 16.0, *) {
                saveImageToDocument(image: image, filename: "\(reminder.id)")
            } else {
            }
        }
        dismiss()
    }
    private func dismiss() {
        dismiss(animated: true)
    }
}
// MARK:  PHPickerViewControllerDelegate
extension AddEditViewController: PHPickerViewControllerDelegate, UINavigationControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if let itemProvider = results.first?.itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.image = image as? UIImage ?? UIImage(systemName: "photo.badge.plus.fill")!
                }
            }
        }
        dismiss(animated: true)
    }
}

extension AddEditViewController: UITextFieldDelegate{
    @objc
    private func textFieldDidChange(sender: UITextField) {
        guard let text = sender.text else {return}
        
        if sender.tag == 0 {
            titleText = text
        } else if sender.tag == 1 {
            contentText = text
        }
        
        if titleText.isEmpty {
            navBarItemAdd.isEnabled = false
        } else {
            navBarItemAdd.isEnabled = true
        }
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
        } else if section == 4 {
            return 2
        } else { return 1 }
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
                cell.textField.tag = indexPath.row
                cell.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            case 1:
                cell.configureCell(placeholer: "내용")
                cell.textField.delegate = self
                cell.textField.tag = indexPath.row
                cell.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
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
        switch indexPath.section {
        case 1:
            let vc = DateViewController()
            vc.date = self.date
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = TagViewController()
            vc.tagString = self.tag
            vc.tagTextField.text = self.tag
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = PrioritySegmentViewController()
            vc.prioritySegNum = self.priority
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            if indexPath.row == 0 {
                print("이미지 추가 눌렀음")
                var configuration = PHPickerConfiguration()
                configuration.selectionLimit = 1 //선택 최대 장수 제한
                configuration.filter = .any(of: [.images]) // 이런 방식으로 사진만, 라이브포토만, 비디오만 .. 등등의 제한 설정 가능.
                let picker = PHPickerViewController(configuration: configuration)
                picker.delegate = self
                present(picker, animated: true)}
        default:
            print("")
        }
    }
}
