//
//  FirstCheckInView.swift
//  Motive
//
//  Created by Michael Bautista on 5/11/25.
//

import SwiftUI
import SwiftData

struct FirstCheckInView: View {
    @EnvironmentObject var navigationController: NavigationController
    @EnvironmentObject var sheetNavigationController: SheetNavigationController
    @EnvironmentObject var userViewModel: UserViewModel
    
    @StateObject var viewModel = CheckInViewModel()
    
    var body: some View {
        VStack {
            Text("What did you do well today?")
                .font(Font.FontStyles.title1)
                .foregroundStyle(Color.ColorSystem.primaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            ZStack(alignment: .topLeading) {
                if viewModel.didWell == "" {
                    Text("Enter your response")
                        .font(Font.FontStyles.body)
                        .foregroundStyle(Color.ColorSystem.systemGray)
                        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                }
                
                TextEditor(text: $viewModel.didWell)
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
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    
                } label: {
                    Text("Cancel")
                        .foregroundStyle(Color.ColorSystem.primaryText)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    sheetNavigationController.push(.SecondCheckInView(viewModel: viewModel))
                } label: {
                    Text("Next")
                        .foregroundStyle(viewModel.didWell == "" ? Color.ColorSystem.systemGray : Color.ColorSystem.primaryText)
                }
                .disabled(viewModel.didWell == "")
            }
        }
    }
}

#Preview {
    FirstCheckInView()
}
