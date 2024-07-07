//
//  ReminderRepository.swift
//  Reminders
//
//  Created by 쌩 on 7/8/24.
//

import Foundation

protocol ReminderRepository {
    
     func getReminders()
     func getReminderById(id: Int)
     func createReminder()
     func updateReminder()
     func deleteReminder()
    
}
extension ReminderRepository {
    func getReminders() {}
    func getReminderById(id: Int) {}
    func createReminder() {}
    func updateReminder() {}
    func deleteReminder() {}
}
