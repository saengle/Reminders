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
    
    func createReminder(data: Reminder) {
        let data = data
        do {
            try realm.write({
                realm.add(data)
            })
        } catch {
            print("data 생성에 error가 발생하였습니다..")
        }
    }
    
    func fetchAll() -> [Reminder] {
        let value = realm.objects(Reminder.self)
        return Array(value)
    }
    
    func updateReminder(oldData: Reminder, newData: Reminder, completion: @escaping() -> ()) {
        do {
            try realm.write {
                let newdata = Reminder(value: [
                    "id": oldData.id,
                    "title": newData.title,
                    "deadLine": newData.deadLine,
                    "content": newData.content,
                    "flag": newData.flag,
                    "isDone": newData.isDone,
                    "priority": newData.priority,
                    "tag": newData.tag,
                    "imagePath": newData.imagePath
                ])
                realm.add(newdata, update: .modified)
                completion()
            }
        } catch {
            print("데이터 업데이트 중 문제가 발생했습니다.")
        }
    }
    
    func deleteReminder(id: ObjectId, completion: @escaping() -> ()) {
        if let reminder = realm.object(ofType: Reminder.self, forPrimaryKey: id) {
            do {
                try realm.write {
                    realm.delete(reminder)
                    completion()
                }
            } catch {
                print("data 삭제에 error가 발생하였습니다..")
            }
        }
      
    }
}
