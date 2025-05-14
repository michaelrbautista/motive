//
//  SheetNavigationViews.swift
//  Motive
//
//  Created by Michael Bautista on 5/13/25.
//

import SwiftUI

// MARK: New quote
struct NewQuoteCoordinatorView: View {
    
    @Binding var navigationController: NavigationController
    @Binding var userViewModel: UserViewModel
    @Binding var viewModel: WidgetsViewModel
    
    @State var sheetNavigationController = SheetNavigationController()
    
    var body: some View {
        NavigationStack(path: $sheetNavigationController.path) {
            sheetNavigationController.build(
                .NewQuoteView(
                    navigationController: $navigationController,
                    sheetNavigationController: $sheetNavigationController,
                    userViewModel: $userViewModel,
                    viewModel: $viewModel
                )
            )
            .navigationDestination(for: Screen.self) { screen in
                sheetNavigationController.build(screen)
            }
            .sheet(item: $sheetNavigationController.sheet) { sheet in
                sheetNavigationController.build(sheet)
            }
        }
    }
}

// MARK: New image
struct NewImageCoordinatorView: View {
    
    @Binding var navigationController: NavigationController
    @Binding var userViewModel: UserViewModel
    @Binding var viewModel: WidgetsViewModel
    
    @State var sheetNavigationController = SheetNavigationController()
    
    var body: some View {
        NavigationStack(path: $sheetNavigationController.path) {
            sheetNavigationController.build(
                .NewImageView(
                    navigationController: $navigationController,
                    sheetNavigationController: $sheetNavigationController,
                    userViewModel: $userViewModel,
                    viewModel: $viewModel
                )
            )
            .navigationDestination(for: Screen.self) { screen in
                sheetNavigationController.build(screen)
            }
            .sheet(item: $sheetNavigationController.sheet) { sheet in
                sheetNavigationController.build(sheet)
            }
        }
    }
}
