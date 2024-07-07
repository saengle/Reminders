//
//  Reminder.swift
//  Reminders
//
//  Created by 쌩 on 7/2/24.
//

import Foundation

import RealmSwift

class Reminder: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var title: String = ""
    @Persisted var priority: Int = 0
    @Persisted var tag: String? = ""
    @Persisted var content: String? = ""
    @Persisted var deadLine = Date()
    @Persisted var imagePath: String?
    @Persisted var isDone: Bool = false
    @Persisted var flag: Bool = false
    
    convenience init(title: String ,priority: Int, content: String?, tag: String? ,deadLine: Date, imagePath: String?, isDone: Bool, flag: Bool) {
        self.init()
        self.title = title
        self.priority = priority
        self.tag = tag
        self.content = content
        self.deadLine = deadLine
        self.imagePath = imagePath
        self.isDone = isDone
        self.flag = flag
    }
}
