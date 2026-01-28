//
//  TaskItem.swift
//  SwiftDataDemo
//
//  Created by Roman Yaschenkov on 28.01.2026.
//

import SwiftUI
import SwiftData

@Model class TaskItem: Identifiable {
    var id: UUID
    var name: String
    var isComplete: Bool
    
    @Transient var priority: TaskPriority {
        get {
            return TaskPriority(rawValue: Int(priorityValue)) ?? .normal
        }
        set {
            priorityValue = Int(newValue.rawValue)
        }
    }
    @Attribute(originalName: "priority") var priorityValue: TaskPriority.RawValue
        
    init(id: UUID = UUID(), name: String = "", priority: TaskPriority = .normal, isComplete: Bool = false) {
        self.id = id
        self.name = name
        self.priorityValue = priority.rawValue
        self.isComplete = isComplete
    }
}
