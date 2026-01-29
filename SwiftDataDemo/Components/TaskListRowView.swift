//
//  TaskListView.swift
//  SwiftDataDemo
//
//  Created by Roman Yaschenkov on 29.01.2026.
//

import SwiftUI

struct TaskListRowView: View {
    @Bindable var taskItem: TaskItem
    
    var body: some View {
        Toggle(isOn: $taskItem.isComplete) {
            HStack {
                Text(taskItem.name)
                    .strikethrough(taskItem.isComplete, color: .black)
                    .bold()
                    .animation(.default)
                
                Spacer()
                
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(color(for: taskItem.priority))
            }
        }.toggleStyle(CheckboxStyle())
    }
                                     
    private func color(for priority: TaskPriority) -> Color {
         switch priority {
         case .high: return .red
         case .normal: return .orange
         case .low: return .green
         }
    }
}
