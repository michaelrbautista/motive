//
//  TopicSelector.swift
//  Motive
//
//  Created by Michael Bautista on 4/30/25.
//

import SwiftUI

struct TopicSelector: View {
    
    var sheetNavigationController: SheetNavigationController
    
    @Binding var topic: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("TOPIC")
                .font(Font.FontStyles.footnote)
                .foregroundStyle(Color.ColorSystem.systemGray)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
            
            Button {
                sheetNavigationController.presentSheet(
                    .SelectTopicView(
                        sheetNavigationController: sheetNavigationController,
                        topic: $topic
                    )
                )
            } label: {
                HStack {
                    if topic == "" {
                        Text("Select topic")
                            .font(Font.FontStyles.body)
                            .foregroundStyle(Color.ColorSystem.systemGray)
                    } else {
                        Text(topic)
                            .font(Font.FontStyles.body)
                            .foregroundStyle(Color.ColorSystem.primaryText)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 12)
                        .foregroundStyle(Color.ColorSystem.systemGray2)
                        .fontWeight(.bold)
                }
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .background(Color.ColorSystem.systemGray6)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    TopicSelector(sheetNavigationController: SheetNavigationController(), topic: .constant("Random"))
}
