//
//  SwiftDataDemoApp.swift
//  SwiftDataDemo
//
//  Created by Roman Yaschenkov on 28.01.2026.
//

import SwiftUI

@main
struct SwiftDataDemoApp: App {
    /*
     * - Настройка контейнера модели для приложения
     *   Ниже мы установили общий контейнер модели для хранения экземпляров TaskItem.
     */
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: TaskItem.self)
    }
}
