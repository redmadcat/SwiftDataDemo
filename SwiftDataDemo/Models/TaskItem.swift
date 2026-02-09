//
//  TaskItem.swift
//  SwiftDataDemo
//
//  Created by Roman Yaschenkov on 28.01.2026.
//

import SwiftUI
import SwiftData

/*
 * Ранее в CoreData для сохранения данных необходимо было отдельно создать модель данных (с расширением файла .xcdatamodeld)
 * с помощью редактора модели данных. С выходом SwiftData в этом больше нет необходимости. SwiftData упрощает весь процесс с помощью макросов, начиная с iOS17.
 *
 * Например для использование SwiftData c классом TaskItem, все, что необходимо сделать (при условии, что класс содержит простые типы данных)
 * это добавить аннотацию @Model в объявлении класса (как в примере ниже). Так мы определяем схему модели данных, SwiftData автоматически включает сохранение
 * данных для класса и предлагает другие функции управления данными.
 *
 * Просто помечая объекты модели аннотацией @Model, SwiftData автоматически изменяет параметры настройки для отслеживания изменений и наблюдения за ними.
 * Это означает, что для обновления элементов не требуется никакой дополнительной реализации в коде.
 */

@Model class TaskItem: Identifiable {
    var id: UUID
    var name: String
    var isComplete: Bool
    
    /*
     * SwiftData позволяет настраивать способ построения вашей схемы с использованием метаданных свойств.
     * - Вы можете добавить ограничения уникальности, используя аннотацию @Attribute например так @Attribute(.unique) var name: String
     * - Настроить правила удаления с помощью аннотации @Relationship
     *   Например, если бы у нас был класс альбом
     *
     *     @Model class Album {
     *         @Attribute(.unique) var name: String
     *         var artist: String
     *         var genre: String
     *
     *         Каскадная связь предписывает SwiftData удалить все песни при удалении альбома.
     *         @Relationship(deleteRule: .cascade) var songs: [Song]? = []
     *      }
     *
     * - Если есть определенные свойства, которые вы не хотите включать, вы можете использовать макрос @Transient,
     *   чтобы указать SwiftData исключить их.
     */
    
    @Transient var priority: TaskPriority {
        get {
            return TaskPriority(rawValue: Int(priorityValue)) ?? .normal
        }
        set {
            priorityValue = Int(newValue.rawValue)
        }
    }
    
    /* - Поскольку TaskPriority является перечислением, он не может быть напрямую сохранен в постоянном хранилище.
     *   Чтобы сохранить перечисление, нам нужно сохранить его исходное значение, которое является целым числом.
     *   В приведенном ниже примере мы добавили новое свойство, которое хранит исходное зачение перечисления (тип Int).
     *   Так же для priorityValue используется другое имя поля в схеме, которое совпадает с названием поля перечисления
     *   (для того чтобы имя поля схемы соответствовало имени свойства)
     */
    
    @Attribute(originalName: "priority") var priorityValue: TaskPriority.RawValue
        
    init(id: UUID = UUID(), name: String = "", priority: TaskPriority = .normal, isComplete: Bool = false) {
        self.id = id
        self.name = name
        self.priorityValue = priority.rawValue
        self.isComplete = isComplete
    }
}
