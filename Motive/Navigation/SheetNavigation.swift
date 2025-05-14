//
//  SheetNavigation.swift
//  Motive
//
//  Created by Michael Bautista on 5/13/25.
//

import SwiftUI

// MARK: Sheet navigation controller
@Observable
class SheetNavigationController: CoordinatorProtocol {
    var path: NavigationPath = NavigationPath()
    var sheet: Sheet? = nil
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func handleDeepLink(_ url: URL) {
        switch url.host {
        default:
            break
        }
    }
    
    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        // MARK: New quote/image
        case .NewQuoteView(let navigationController, let sheetNavigationController, let userViewModel, let viewModel):
            NewQuoteView(
                navigationController: navigationController,
                sheetNavigationController: sheetNavigationController,
                userViewModel: userViewModel,
                viewModel: viewModel
            )
        case .NewImageView(let navigationController, let sheetNavigationController, let userViewModel, let viewModel):
            NewImageView(
                navigationController: navigationController,
                sheetNavigationController: sheetNavigationController,
                userViewModel: userViewModel,
                viewModel: viewModel
            )
        default:
            Text("Navigation Error")
        }
    }
    
    // MARK: Sheet views
    @ViewBuilder
    func build(_ sheet: Sheet) -> some View {
        switch sheet {
        default:
            Text("Navigation Error")
        }
    }
}
