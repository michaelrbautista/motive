//
//  SettingsView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var navigationController: NavigationController
    @Binding var userViewModel: UserViewModel
    
    @State var signOutIsLoading = false
    
    @State var presentConfirmSignOut = false
    @State var presentConfirmDeleteAccount = false
    
    var body: some View {
        List {
            // MARK: Reminder time
            Section {
                Button {
                    navigationController.presentSheet(.CheckInTimeView(navigationController: $navigationController, userViewModel: $userViewModel))
                } label: {
                    Text("Check in time")
                }
            }
            
            // MARK: Terms and privacy
            Section {
                Button {
                    if let url = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula") {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    Text("Terms and conditions")
                        .font(Font.FontStyles.body)
                        .foregroundStyle(Color.ColorSystem.primaryText)
                }
                
                Button {
                    if let url = URL(string: "https://michaelrbautista.github.io/appstoreprivacy/") {
                        UIApplication.shared.open(url)
                    }
                } label: {
                        Text("Privacy policy")
                            .font(Font.FontStyles.body)
                            .foregroundStyle(Color.ColorSystem.primaryText)
                }
            }
            
            // MARK: Sign out
            Section {
                Button {
                    presentConfirmSignOut.toggle()
                } label: {
                    if signOutIsLoading {
                        ProgressView()
                            .tint(Color.ColorSystem.primaryText)
                    } else {
                        Text("Sign out")
                            .font(Font.FontStyles.body)
                            .foregroundStyle(Color.ColorSystem.primaryText)
                    }
                }
            }
            
            // MARK: Delete account
            Section {
                Button {
                    presentConfirmDeleteAccount.toggle()
                } label: {
                    Text("Delete account")
                        .font(Font.FontStyles.body)
                        .foregroundStyle(Color.ColorSystem.systemRed)
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text("MOTIVE")
                    .font(.custom("InterDisplay-Bold", size: 12))
                    .foregroundStyle(Color.ColorSystem.primaryText)
            }
        })
        .alert(Text("Are you sure you want to sign out?"), isPresented: $presentConfirmSignOut) {
            Button(role: .destructive) {
                // Sign out
                signOutIsLoading = true
                
                Task {
                    do {
                        try await SupabaseService.shared.supabase.auth.signOut()
                        
                        DispatchQueue.main.async {
                            UserService.currentUser = nil
                            self.userViewModel.isLoggedIn = false
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Sign out")
            }
        }
        .alert(Text("Are you sure you want to delete your account?"), isPresented: $presentConfirmDeleteAccount) {
            Button(role: .destructive) {
                // Delete account
                Task {
                    do {
                        guard let currentUserId = UserService.currentUser?.id else {
                            return
                        }
                        
                        try await UserService.shared.deleteUser(uid: currentUserId)
                        
                        // Clear defaults
                        let defaults = UserDefaults.standard
                        for key in defaults.dictionaryRepresentation().keys {
                            defaults.removeObject(forKey: key)
                        }
                        
                        if let widgetDefaults = UserDefaults(suiteName: "group.Michael-Bautista.motive") {
                            for key in widgetDefaults.dictionaryRepresentation().keys {
                                widgetDefaults.removeObject(forKey: key)
                            }
                            widgetDefaults.synchronize()
                        }
                        
                        DispatchQueue.main.async {
                            UserService.currentUser = nil
                            self.userViewModel.isLoggedIn = false
                        }
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Delete")
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView(navigationController: .constant(NavigationController()), userViewModel: .constant(UserViewModel()))
    }
}
