//
//  UseCases.swift
//  Reminders
//
//  Created by 쌩 on 7/8/24.
//

import Foundation

 class UseCases {
    
    let createReminder: CreateReminder
    let readReminder: ReadReminder
    let readReminders: ReadReminders
    let updateReminder: UpdateReminder
    let deleteReminder: DeleteReminder
    
    init(createReminder: CreateReminder, readReminder: ReadReminder, readReminders: ReadReminders, updateReminder: UpdateReminder, deleteReminder: DeleteReminder) {
        self.createReminder = createReminder
        self.readReminder = readReminder
        self.readReminders = readReminders
        self.updateReminder = updateReminder
        self.deleteReminder = deleteReminder
    }
}
