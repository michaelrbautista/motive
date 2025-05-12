//
//  ThirdCheckInView.swift
//  Motive
//
//  Created by Michael Bautista on 5/11/25.
//

import SwiftUI
import SwiftData

struct ThirdCheckInView: View {
    var navigationController: NavigationController
    var sheetNavigationController: SheetNavigationController
    var userViewModel: UserViewModel
    
    @State var viewModel: CheckInViewModel
    
    var body: some View {
        VStack {
            Text("What will you do better tomorrow?")
                .font(Font.FontStyles.title1)
                .foregroundStyle(Color.ColorSystem.primaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            ZStack(alignment: .topLeading) {
                if viewModel.willDoBetter == "" {
                    Text("Enter your response")
                        .font(Font.FontStyles.body)
                        .foregroundStyle(Color.ColorSystem.systemGray)
                        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                }
                
                TextEditor(text: $viewModel.willDoBetter)
                    .frame(height: 200)
                    .scrollContentBackground(.hidden)
            }
            .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
            .background(Color.ColorSystem.systemGray6)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Spacer()
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
        .background(Color.ColorSystem.systemBackground)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // Save entry
                    
                    
                    navigationController.dismissSheet()
                } label: {
                    Text("Save")
                        .foregroundStyle(viewModel.willDoBetter == "" ? Color.ColorSystem.systemGray : Color.ColorSystem.systemBlue)
                }
                .disabled(viewModel.willDoBetter == "")
            }
        }
    }
}

#Preview {
    ThirdCheckInView(navigationController: NavigationController(), sheetNavigationController: SheetNavigationController(), userViewModel: UserViewModel(), viewModel: CheckInViewModel())
}
