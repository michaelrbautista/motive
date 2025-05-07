//
//  NewImageView.swift
//  Motive
//
//  Created by Michael Bautista on 5/6/25.
//

import SwiftUI

struct NewImageView: View {
    @EnvironmentObject var navigationController: NavigationController
    @EnvironmentObject var sheetNavigationController: SheetNavigationController
    @EnvironmentObject var userViewModel: UserViewModel
    
    @StateObject var viewModel: WidgetsViewModel
    
    @State var presentConfirmSave = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // MARK: Topic selector
                TopicSelector(topic: $viewModel.imageTopic)
                
                
                if let image = UIImage(data: viewModel.newImage) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 170)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else if let image = UIImage(data: viewModel.originalImage) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 170)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    Image("davidGoggins")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 170)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                // MARK: Generate button
                Button {
                    viewModel.getNewImage()
                } label: {
                    HStack {
                        Spacer()
                        if viewModel.imageIsLoading {
                            ProgressView()
                                .tint(Color.ColorSystem.primaryText)
                        } else {
                            Text("Generate")
                                .font(Font.FontStyles.headline)
                                .foregroundStyle(Color.ColorSystem.primaryText)
                        }
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .background(Color.ColorSystem.systemBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .disabled(viewModel.imageIsLoading)
                
                Spacer()
            }
            .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 20))
            .background(Color.ColorSystem.systemBackground)
            .navigationTitle("New Image")
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
                        presentConfirmSave.toggle()
                    } label: {
                        Text("Save")
                            .foregroundStyle(!viewModel.hasGeneratedImage ? Color.ColorSystem.systemGray : Color.ColorSystem.systemBlue)
                    }
                }
            }
            .alert(Text("Are you sure you want to save? This will overwrite the current image."), isPresented: $presentConfirmSave) {
                Button(role: .cancel) {} label: {
                    Text("Cancel")
                }
                
                Button(role: .none) {
                    // Save image
                    let userDefaults = UserDefaults(suiteName: "group.Michael-Bautista.motive")
                    userDefaults?.set(viewModel.newImage, forKey: "image")
                    
                    viewModel.originalImage = viewModel.newImage
                    
                    userViewModel.image = viewModel.newImage
                    viewModel.newImage = Data()
                    
                    navigationController.dismissSheet()
                } label: {
                    Text("Save")
                        .foregroundStyle(viewModel.imageIsLoading ? Color.ColorSystem.systemGray5 : Color.ColorSystem.systemBlue)
                }
                .disabled(!viewModel.hasGeneratedImage || viewModel.imageIsLoading)
            }
        }
    }
}

#Preview {
    NewImageView(viewModel: WidgetsViewModel())
}
