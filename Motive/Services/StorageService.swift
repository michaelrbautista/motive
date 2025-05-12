//
//  StorageService.swift
//  Motive
//
//  Created by Michael Bautista on 5/4/25.
//

import SwiftUI

final class StorageService: ObservableObject {
    
    public static let shared = StorageService()
    
    // MARK: Get image
    public func getImage() async throws -> Data? {
        var folderPath = "self_improvement"
        
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
