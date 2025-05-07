//
//  NavigationViews.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

// MARK: Widgets
struct WidgetsCoordinatorView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @StateObject var navigationController: NavigationController = NavigationController()
    
    var body: some View {
        NavigationStack(path: $navigationController.path) {
            navigationController.build(.WidgetsView)
                .environmentObject(userViewModel)
                .navigationDestination(for: Screen.self) { screen in
                    navigationController.build(screen)
                }
                .sheet(item: $navigationController.sheet) { sheet in
                    navigationController.build(sheet)
                }
                .fullScreenCover(item: $navigationController.fullScreenCover) { fullScreenCover in
                    navigationController.build(fullScreenCover)
                }
        }
        .environmentObject(navigationController)
    }
}

// MARK: New quote
struct NewQuoteCoordinatorView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var navigationController: NavigationController
    
    @StateObject var sheetNavigationController = SheetNavigationController()
    
    @StateObject var viewModel: WidgetsViewModel
    
    var body: some View {
        NavigationStack(path: $sheetNavigationController.path) {
            sheetNavigationController.build(.NewQuoteView(viewModel: viewModel))
                .environmentObject(userViewModel)
                .navigationDestination(for: Screen.self) { screen in
                    sheetNavigationController.build(screen)
                }
                .sheet(item: $sheetNavigationController.sheet) { sheet in
                    sheetNavigationController.build(sheet)
                }
                .fullScreenCover(item: $sheetNavigationController.fullScreenCover) { fullScreenCover in
                    sheetNavigationController.build(fullScreenCover)
                }
        }
        .environmentObject(navigationController)
        .environmentObject(sheetNavigationController)
    }
}

// MARK: New image
struct NewImageCoordinatorView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var navigationController: NavigationController
    
    @StateObject var sheetNavigationController = SheetNavigationController()
    
    @StateObject var viewModel: WidgetsViewModel
    
    var body: some View {
        NavigationStack(path: $sheetNavigationController.path) {
            sheetNavigationController.build(.NewImageView(viewModel: viewModel))
                .environmentObject(userViewModel)
                .navigationDestination(for: Screen.self) { screen in
                    sheetNavigationController.build(screen)
                }
                .sheet(item: $sheetNavigationController.sheet) { sheet in
                    sheetNavigationController.build(sheet)
                }
                .fullScreenCover(item: $sheetNavigationController.fullScreenCover) { fullScreenCover in
                    sheetNavigationController.build(fullScreenCover)
                }
        }
        .environmentObject(navigationController)
        .environmentObject(sheetNavigationController)
    }
}

// MARK: Settings
struct SettingsCoordinatorView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @StateObject var navigationController: NavigationController = NavigationController()
    
    var body: some View {
        NavigationStack(path: $navigationController.path) {
            navigationController.build(.SettingsView(selectedTopics: userViewModel.topics))
                .environmentObject(userViewModel)
                .navigationDestination(for: Screen.self) { screen in
                    navigationController.build(screen)
                }
                .sheet(item: $navigationController.sheet) { sheet in
                    navigationController.build(sheet)
                }
                .fullScreenCover(item: $navigationController.fullScreenCover) { fullScreenCover in
                    navigationController.build(fullScreenCover)
                }
        }
        .environmentObject(navigationController)
    }
}

// MARK: Landing page
struct LandingPageCoordinatorView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @StateObject var navigationController: NavigationController = NavigationController()
    
    var body: some View {
        NavigationStack(path: $navigationController.path) {
            navigationController.build(.LandingPageView)
                .environmentObject(userViewModel)
                .navigationDestination(for: Screen.self) { screen in
                    navigationController.build(screen)
                }
                .sheet(item: $navigationController.sheet) { sheet in
                    navigationController.build(sheet)
                }
                .fullScreenCover(item: $navigationController.fullScreenCover) { fullScreenCover in
                    navigationController.build(fullScreenCover)
                }
        }
        .environmentObject(navigationController)
    }
}
