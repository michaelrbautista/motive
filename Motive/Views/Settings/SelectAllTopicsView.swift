//
//  SelectAllTopicsView.swift
//  Motive
//
//  Created by Michael Bautista on 4/30/25.
//

import SwiftUI

struct SelectAllTopicsView: View {
    
    var navigationController: NavigationController
    var userViewModel: UserViewModel
    
    var topics = [
        "Self improvement",
        "Entrepreneurship",
        "Sports"
    ]
    
    @Binding var selectedTopics: [String]
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(topics, id: \.self) { topic in
                    Button {
                        if selectedTopics.contains(topic) {
                            if let index = selectedTopics.firstIndex(of: topic) {
                                selectedTopics.remove(at: index)
                            }
                        } else {
                            selectedTopics.append(topic)
                        }
                    } label: {
                        HStack {
                            Image(systemName: "checkmark")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 12)
                                .foregroundStyle(
                                    selectedTopics.contains(topic) ? Color.ColorSystem.systemBlue : Color.clear
                                )
                                .fontWeight(.bold)
                            
                            Text(topic)
                                .font(Font.FontStyles.body)
                                .foregroundStyle(Color.ColorSystem.primaryText)
                            Spacer()
                        }
                    }
                    .listRowBackground(Color.ColorSystem.systemGray6)
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color.ColorSystem.systemBackground)
            .interactiveDismissDisabled()
            .navigationTitle("Topics")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        navigationController.dismissSheet()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(Color.ColorSystem.primaryText)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // Save to UserDefaults
                        UserDefaults.standard.set(selectedTopics, forKey: "topics")
                        
                        // Update userViewModel
                        userViewModel.topics = selectedTopics
                        
                        navigationController.dismissSheet()
                    } label: {
                        Text("Save")
                            .foregroundStyle(selectedTopics.count == 0 ? Color.ColorSystem.systemGray : Color.ColorSystem.primaryText)
                    }
                    .disabled(selectedTopics.count == 0)
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        SelectAllTopicsView(navigationController: NavigationController(), userViewModel: UserViewModel(), selectedTopics: .constant(["Self improvement", "Entrepreneurship"]))
        SelectAllTopicsView(navigationController: NavigationController(), userViewModel: UserViewModel(), selectedTopics: .constant([]))
    }
}
