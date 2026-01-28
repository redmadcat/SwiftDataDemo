//
//  PriorityView.swift
//  SwiftDataDemo
//
//  Created by Roman Yaschenkov on 28.01.2026.
//

import SwiftUI

struct PriorityView: View {
    var priority: String
    
    var body: some View {
        Text(priority)
            .font(.system(.headline, design: .rounded))
            .padding(10)
            .foregroundStyle(.white)
            .cornerRadius(8)
    }
}

#Preview {
    PriorityView(priority: "High")
}
