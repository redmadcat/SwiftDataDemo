//
//  TaskCreationView.swift
//  SwiftDataDemo
//
//  Created by Roman Yaschenkov on 28.01.2026.
//

import SwiftUI

struct TaskCreationView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Binding var isShow: Bool
    @State var name: String
    @State var priority: TaskPriority
    @State var isEditing = false
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Add a new task")
                        .font(.system(.title, design: .rounded))
                        .bold()
                    
                    Spacer()
                    
                    Button(action: {
                        isShow = false
                    }) {
                        Image(systemName: "xmark")
                            .foregroundStyle(.black)
                            .font(.headline)
                    }
                }
                
                TextField("Enter the task description", text: $name, onEditingChanged: { editingChanged in
                    isEditing = editingChanged
                })
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.bottom)
                
                Text("Priority")
                    .font(.system(.subheadline, design: .rounded))
                    .padding(.bottom)
                
                HStack {
                    PriorityView(priority: "High")
                        .background(priority == .high ? Color.red : Color(.systemGray4))
                        .onTapGesture {
                            priority = .high
                        }
                    
                    PriorityView(priority: "Normal")
                        .background(priority == .normal ? Color.orange : Color(.systemGray4))
                        .onTapGesture {
                            priority = .normal
                        }
                    
                    PriorityView(priority: "Low")
                        .background(priority == .low ? Color.green : Color(.systemGray4))
                        .onTapGesture {
                            priority = .low
                        }
                }
                .padding(.bottom, 30)
                
                Button(action: {
                    if name.trimmingCharacters(in: .whitespaces) == "" {
                        return
                    }
                    
                    isShow = false
                    addTask(name: name, priority: priority)
                }) {
                    Text("Save")
                        .font(.system(.headline, design: .rounded))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundStyle(.white)
                        .background(.purple)
                        .cornerRadius(10)
                }
                .padding(.bottom)
            }
            .padding()
            .background(.white)
            .cornerRadius(10, antialiased: true)
            .offset(y: isEditing ? -320 : 0)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func addTask(name: String, priority: TaskPriority, isComplete: Bool = false) {
        let task = TaskItem(name: name, priority: priority, isComplete: isComplete)
        modelContext.insert(task)
    }
}

#Preview {
    TaskCreationView(isShow: .constant(true), name: "", priority: .normal)
}
