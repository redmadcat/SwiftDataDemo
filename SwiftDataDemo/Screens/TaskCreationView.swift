//
//  TaskCreationView.swift
//  SwiftDataDemo
//
//  Created by Roman Yaschenkov on 28.01.2026.
//

import SwiftUI

struct TaskCreationView: View {
    /*
     * - Настроив контейнер модели в SwiftDataDemoApp (.modelContainer(for: TaskItem.self)),
     *   мы готовы использовать контекст модели для извлечения и сохранения данных.
     */
    @Environment(\.modelContext) private var modelContext
    
    @Binding var isShow: Bool
    @State private var name: String = ""
    @State private var priority: TaskPriority = .normal
    @State private var isValid = false
    
    var body: some View {
        VStack {
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
                
                TextField("Enter the task description", text: $name)
                    .onChange(of: name) {
                        isValid = !name.isEmpty
                    }
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
                .disabled(!isValid)
                .opacity(isValid ? 1 : 0.5)
                .padding([.top, .bottom], 30)
                
                Spacer()
            }
            .padding()
            .background(.white)
            .cornerRadius(10, antialiased: true)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    /*
     * - Чтобы добавить новый элемент, достаточно вызвать метод insert модели контекста и передать ей элемент в качестве параметра.
     */
    private func addTask(name: String, priority: TaskPriority, isComplete: Bool = false) {
        let task = TaskItem(name: name, priority: priority, isComplete: isComplete)
        modelContext.insert(task)
    }
}

#Preview {
    TaskCreationView(isShow: .constant(true))
}
