//
//  UserService.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI
import Supabase

final class UserService {
    
    public static let shared = UserService()
    public static var currentUser: User? = nil
    
    // MARK: Check if username exists
    public func checkUsername(username: String) async -> Bool {
        do {
            let count = try await SupabaseService.shared.supabase
                .from("users")
                .select("*", head: true, count: .exact)
                .eq("username", value: username)
                .execute()
                .count
            
            if let usernameCount = count {
                if usernameCount > 0 {
                    return false
                } else {
                    return true
                }
            } else {
                return false
            }
        } catch {
            print("Error checking username")
            print(error.localizedDescription)
            return false
        }
    }
    
    // MARK: Get user
    public func getUser(uid: String) async throws -> User {
        do {
            let user: User = try await SupabaseService.shared.supabase
                .from("users")
                .select(
                    """
                        id,
                        created_at,
                        email
                    """
                )
                .eq("id", value: uid)
                .single()
                .execute()
                .value
            
            return user
        } catch {
            print("Couldn't get user")
            throw error
        }
    }
    
    // MARK: Create user
    public func createUser(user: User) async throws -> User {
        do {
            let user: User = try await SupabaseService.shared.supabase
                .from("users")
                .insert(user)
                .select(
                    """
                        id,
                        created_at,
                        email
                    """
                )
                .single()
                .execute()
                .value
            
            return user
        } catch {
            print("Error creating user in database")
            throw error
        }
    }
    
    // MARK: Delete user
    public func deleteUser(uid: String) async throws {
        do {
            try await SupabaseService.shared.supabase.rpc("delete_user")
            .execute()
        } catch {
            throw error
        }
    }
    
}
