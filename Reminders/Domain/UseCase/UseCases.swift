//
//  UseCases.swift
//  Reminders
//
//  Created by 쌩 on 7/8/24.
//

import Foundation

 class UseCases {
    
    let createReminderUseCase: CreateReminderUseCase
    let readReminderUseCase: ReadReminderUseCase
    let readRemindersUseCase: ReadRemindersUseCase
    let updateReminderUseCase: UpdateReminderUseCase
    let deleteReminderUseCase: DeleteReminderUseCase
    
    init(createReminderUseCase: CreateReminderUseCase, readReminderUseCase: ReadReminderUseCase, readRemindersUseCase: ReadRemindersUseCase, updateReminderUseCase: UpdateReminderUseCase, deleteReminderUseCase: DeleteReminderUseCase) {
        self.createReminderUseCase = createReminderUseCase
        self.readReminderUseCase = readReminderUseCase
        self.readRemindersUseCase = readRemindersUseCase
        self.updateReminderUseCase = updateReminderUseCase
        self.deleteReminderUseCase = deleteReminderUseCase
    }
}
