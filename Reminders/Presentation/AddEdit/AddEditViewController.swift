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
