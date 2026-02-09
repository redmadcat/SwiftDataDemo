//
//  ContentView.swift
//  SwiftDataDemo
//
//  Created by Roman Yaschenkov on 28.01.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    /*
     * - Настроив контейнер модели в SwiftDataDemoApp (.modelContainer(for: TaskItem.self)),
     *   мы готовы использовать контекст модели для извлечения и сохранения данных.
     */
    @Environment(\.modelContext) private var modelContext
    @State private var newTaskIsShow = false
        
    /*
     * - @Query автоматически извлекает необходимые данные для нас, для простого извлечения данных,
     *   достаточно определения - (@Query var taskItems: [TaskItem])
     *   В приведенном ниже примере мы указываем, что нам необходимо извлекать экземпляры TaskItem,
     *   так же дополнительно указываем опцию сортировки элементов согласно приоритету.
     */
    @Query(sort: \TaskItem.priorityValue, order: .reverse) private var taskItems: [TaskItem]
        
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Task List")
                        .font(.system(size: 40, weight: .black, design: .rounded))
                    
                    Spacer()
                    
                    Button(action: {
                        newTaskIsShow = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.purple)
                    }
                }
                .padding([.top, .leading, .trailing])
                
                taskItems.count == 0 ?
                    AnyView(NoDataView()) :
                    AnyView(
                        List {
                            ForEach(taskItems) { taskItem in
                                TaskListRowView(taskItem: taskItem)
                            }
                            .onDelete(perform: deleteTask)
                        }
                        .listStyle(.plain))
            }
        }.sheet(isPresented: $newTaskIsShow) {
            TaskCreationView(isShow: $newTaskIsShow)
                .presentationDetents([.medium])
        }
    }
    
    /*
     * - Для демонстрации функции удаления, используем набор индексов, в котором хранятся индексы элементов, подлежащие удалению.
     *   Чтобы удалить элемент из постоянного хранилища, достаточно вызвать функцию удаления (delete)
     *   в контексте модели и передать элемент который необходимо удалить в качестве параметра.
     */
    private func deleteTask(indexSet: IndexSet) {
        for index in indexSet {
            let itemToDelete = taskItems[index]
            modelContext.delete(itemToDelete)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: TaskItem.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        for index in 0..<5 {
            let newItem = TaskItem(name: "Task item #\(index)")
            container.mainContext.insert(newItem)
        }
        
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
