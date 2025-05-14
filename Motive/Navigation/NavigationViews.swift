//
//  NavigationViews.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

// MARK: Home
struct HomeCoordinatorView: View {
    
    @Binding var userViewModel: UserViewModel
    
    @State var navigationController: NavigationController = NavigationController()
    
    var body: some View {
        NavigationStack(path: $navigationController.path) {
            navigationController.build(
                .HomeView(
                    navigationController: $navigationController,
                    userViewModel: $userViewModel
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

// MARK: Widgets
struct WidgetsCoordinatorView: View {
    
    @Binding var userViewModel: UserViewModel
    
    @State var navigationController: NavigationController = NavigationController()
    
    var body: some View {
        NavigationStack(path: $navigationController.path) {
            navigationController.build(
                .WidgetsView(
                    navigationController: $navigationController,
                    userViewModel: $userViewModel
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

// MARK: Settings
struct SettingsCoordinatorView: View {
    
    @Binding var userViewModel: UserViewModel
    
    @State var navigationController: NavigationController = NavigationController()
    
    var body: some View {
        NavigationStack(path: $navigationController.path) {
            navigationController.build(
                .SettingsView(
                    navigationController: $navigationController,
                    userViewModel: $userViewModel
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

// MARK: Landing page
struct LandingPageCoordinatorView: View {
    
    @Binding var userViewModel: UserViewModel
    
    @State var navigationController: NavigationController = NavigationController()
    
    var body: some View {
        NavigationStack(path: $navigationController.path) {
            navigationController.build(
                .LandingPageView(
                    navigationController: $navigationController,
                    userViewModel: $userViewModel)
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
