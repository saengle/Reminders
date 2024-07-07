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
    
    func deleteReminder(num: Int, completion: @escaping() -> ()) {
        let list = realm.objects(Reminder.self)
        //        removeImageFromDocument(filename: "\(data.id)")
        //                    램을 지우기 전에 이미지를 지워야 램의 아이디를 사용해서 경로로 파일 삭제 가능 !
        
        do {
            let data = list[num]
            try realm.write {
                // Delete the Todo.
                realm.delete(data)
                completion()
                }
        } catch {
                print("data 삭데에 error가 발생하였습니다..")
        }
    }
}
