//
//  RealmDBHelper.swift
//  Reminders
//
//  Created by 쌩 on 7/8/24.
//

import Foundation

import RealmSwift

class RealmDBHelper {
    
    private let realm = try! Realm()
    
    func createReminder() {
        let data = Reminder(title: "test", priority: 0, content: "안녕 디지몬", tag: "#안녕", deadLine: Date(), imagePath: nil, isDone: false)
        do {
            try realm.write({
                realm.add(data)
                print("Realm Create Succeed")
            })
        } catch {
            print("data 생성에 error가 발생하였습니다..")
        }
    }
    
    func fetchAll() -> [Reminder] {
        let value = realm.objects(Reminder.self)
        return Array(value)
    }
}
