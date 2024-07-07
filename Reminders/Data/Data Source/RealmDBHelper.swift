//
//  RealmDBHelper.swift
//  Reminders
//
//  Created by 쌩 on 7/8/24.
//

import Foundation

import RealmSwift

class RealmDBHelper {
    
    let realm = try! Realm()
    
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
    
    func deleteReminder(num: Int, completion: @escaping() -> ()) {
        let list = realm.objects(Reminder.self)
        
        do {
            let data = list[num]
            try realm.write {
                realm.delete(data)
                completion()
                }
        } catch {
                print("data 삭제에 error가 발생하였습니다..")
        }
    }
}
