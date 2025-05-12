//
//  NavigationViews.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

// MARK: Home
struct HomeCoordinatorView: View {
    
    var userViewModel: UserViewModel
    
    @State var navigationController: NavigationController = NavigationController()
    
    var body: some View {
        NavigationStack(path: $navigationController.path) {
            navigationController.build(
                .HomeView(
                    navigationController: navigationController,
                    userViewModel: userViewModel
                )
            )
            .navigationDestination(for: Screen.self) { screen in
                navigationController.build(screen)
            }
            .sheet(item: $navigationController.sheet) { sheet in
                navigationController.build(sheet)
            }
        }
    }
}

// MARK: Check in
struct CheckInCoordinatorView: View {
    
    var navigationController: NavigationController
    var userViewModel: UserViewModel
    
    @State var sheetNavigationController = SheetNavigationController()
    
    var body: some View {
        NavigationStack(path: $sheetNavigationController.path) {
            sheetNavigationController.build(
                .FirstCheckInView(
                    navigationController: navigationController,
                    sheetNavigationController: sheetNavigationController,
                    userViewModel: userViewModel
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

// MARK: Widgets
struct WidgetsCoordinatorView: View {
    
    var userViewModel: UserViewModel
    
    @State var navigationController: NavigationController = NavigationController()
    
    var body: some View {
        NavigationStack(path: $navigationController.path) {
            navigationController.build(
                .WidgetsView(
                    navigationController: navigationController,
                    userViewModel: userViewModel
                )
            )
            .navigationDestination(for: Screen.self) { screen in
                navigationController.build(screen)
            }
            .sheet(item: $navigationController.sheet) { sheet in
                navigationController.build(sheet)
            }
        }
    }
}

// MARK: New quote
struct NewQuoteCoordinatorView: View {
    
    var navigationController: NavigationController
    var userViewModel: UserViewModel
    
    @State var sheetNavigationController = SheetNavigationController()
    
    @State var viewModel: WidgetsViewModel
    
    var body: some View {
        NavigationStack(path: $sheetNavigationController.path) {
            sheetNavigationController.build(
                .NewQuoteView(
                    navigationController: navigationController,
                    sheetNavigationController: sheetNavigationController,
                    userViewModel: userViewModel,
                    viewModel: viewModel
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
    
    var navigationController: NavigationController
    var userViewModel: UserViewModel
    
    @State var sheetNavigationController = SheetNavigationController()
    
    @State var viewModel: WidgetsViewModel
    
    var body: some View {
        NavigationStack(path: $sheetNavigationController.path) {
            sheetNavigationController.build(
                .NewImageView(
                    navigationController: navigationController,
                    sheetNavigationController: sheetNavigationController,
                    userViewModel: userViewModel,
                    viewModel: viewModel
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

// MARK: Settings
struct SettingsCoordinatorView: View {
    
    var userViewModel: UserViewModel
    
    @State var navigationController: NavigationController = NavigationController()
    
    var body: some View {
        NavigationStack(path: $navigationController.path) {
            navigationController.build(
                .SettingsView(
                    navigationController: navigationController,
                    userViewModel: userViewModel,
                    selectedTopics: userViewModel.topics)
            )
            .navigationDestination(for: Screen.self) { screen in
                navigationController.build(screen)
            }
            .sheet(item: $navigationController.sheet) { sheet in
                navigationController.build(sheet)
            }
        }
    }
}

// MARK: Landing page
struct LandingPageCoordinatorView: View {
    
    var userViewModel: UserViewModel
    
    @State var navigationController: NavigationController = NavigationController()
    
    var body: some View {
        NavigationStack(path: $navigationController.path) {
            navigationController.build(
                .LandingPageView(
                    navigationController: navigationController,
                    userViewModel: userViewModel)
            )
            .navigationDestination(for: Screen.self) { screen in
                navigationController.build(screen)
            }
            .sheet(item: $navigationController.sheet) { sheet in
                navigationController.build(sheet)
            }
        }
    }
}
