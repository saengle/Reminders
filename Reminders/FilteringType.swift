//
//  FilteringType.swift
//  Reminders
//
//  Created by 쌩 on 7/9/24.
//

import Foundation

enum FilteringType: String, CaseIterable {
    case today = "Today"
    case scheduled = "Scheduled"
    case all = "All"
    case flagged = "Flagged"
    case completed = "Completed"
}
