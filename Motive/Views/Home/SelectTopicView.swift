//
//  SelectTopicView.swift
//  Motive
//
//  Created by Michael Bautista on 4/29/25.
//

import SwiftUI

struct SelectTopicView: View {
    @EnvironmentObject var navigationController: NavigationController
    
    @Binding var topic: String
    
    var body: some View {
        List {
            Button {
                topic = "Self improvement"
                navigationController.dismissSheet()
            } label: {
                Text("Self improvement")
                    .font(Font.FontStyles.body)
                    .foregroundStyle(Color.ColorSystem.primaryText)
            }
            .listRowBackground(Color.ColorSystem.systemGray6)
            
            Button {
                topic = "Faith"
                navigationController.dismissSheet()
            } label: {
                Text("Faith")
                    .font(Font.FontStyles.body)
                    .foregroundStyle(Color.ColorSystem.primaryText)
            }
            .listRowBackground(Color.ColorSystem.systemGray6)
            
            Button {
                topic = "Entrepreneurship"
                navigationController.dismissSheet()
            } label: {
                Text("Entrepreneurship")
                    .font(Font.FontStyles.body)
                    .foregroundStyle(Color.ColorSystem.primaryText)
            }
            .listRowBackground(Color.ColorSystem.systemGray6)
            
            Button {
                topic = "Sports"
                navigationController.dismissSheet()
            } label: {
                Text("Sports")
                    .font(Font.FontStyles.body)
                    .foregroundStyle(Color.ColorSystem.primaryText)
            }
            .listRowBackground(Color.ColorSystem.systemGray6)
            
            Button {
                topic = "Weightlifting"
                navigationController.dismissSheet()
            } label: {
                Text("Weightlifting")
                    .font(Font.FontStyles.body)
                    .foregroundStyle(Color.ColorSystem.primaryText)
            }
            .listRowBackground(Color.ColorSystem.systemGray6)
            
            Button {
                topic = "Anime"
                navigationController.dismissSheet()
            } label: {
                Text("Anime")
                    .font(Font.FontStyles.body)
                    .foregroundStyle(Color.ColorSystem.primaryText)
            }
            .listRowBackground(Color.ColorSystem.systemGray6)
            
            Button {
                topic = "Random"
                navigationController.dismissSheet()
            } label: {
                Text("Random")
                    .font(Font.FontStyles.body)
                    .foregroundStyle(Color.ColorSystem.primaryText)
            }
            .listRowBackground(Color.ColorSystem.systemGray6)
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(Color.ColorSystem.systemBackground)
    }
}

#Preview {
    SelectTopicView(topic: .constant(""))
}
