//
//  StorageService.swift
//  Motive
//
//  Created by Michael Bautista on 5/4/25.
//

import SwiftUI

final class StorageService {
    
    public static let shared = StorageService()
    
    // MARK: Save image
    public func saveImage(image: Data) {
        let userDefaults = UserDefaults(suiteName: "group.Michael-Bautista.motive")
        userDefaults?.set(image, forKey: "image")
    }
    
    // MARK: Get image
    public func getImage() async throws -> Data? {
        let folderPath = "self_improvement"
        
        let files = try await SupabaseService.shared.supabase.storage
            .from("images")
            .list(path: folderPath)
        
        let randomImage = files.randomElement()
        
        guard let img = randomImage else { return nil }
        
        let imageData = try await SupabaseService.shared.supabase.storage
            .from("images")
            .download(path: "\(folderPath)/\(img.name)")
        
        return imageData
    }
    
}
