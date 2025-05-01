//
//  SelectTopicView.swift
//  Motive
//
//  Created by Michael Bautista on 4/29/25.
//

import SwiftUI

struct SelectTopicView: View {
    @EnvironmentObject var navigationController: NavigationController
    
    var topics = [
        "Self improvement",
        "Entrepreneurship",
        "Sports",
        "Religion"
    ]
    
    @Binding var topic: String
    
    var body: some View {
        List {
            ForEach(topics, id: \.self) { topic in
                Button {
                    self.topic = topic
                    navigationController.dismissSheet()
                } label: {
                    Text(topic)
                        .font(Font.FontStyles.body)
                        .foregroundStyle(Color.ColorSystem.primaryText)
                }
                .listRowBackground(Color.ColorSystem.systemGray6)
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(Color.ColorSystem.systemBackground)
    }
}

#Preview {
    SelectTopicView(topic: .constant(""))
}
