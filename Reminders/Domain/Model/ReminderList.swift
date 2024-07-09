//
//  ReminderList.swift
//  Reminders
//
//  Created by 쌩 on 7/9/24.
//

import Foundation

import RealmSwift

class ReminderList: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = ""
    @Persisted var reminders = List<Reminder>()
}
