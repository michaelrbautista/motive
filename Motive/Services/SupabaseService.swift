//
//  SupabaseService.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI
import Supabase

final class SupabaseService {
    
    public static let shared = SupabaseService()
    public var supabase: SupabaseClient
    
    init() {
        self.supabase = SupabaseClient(
            supabaseURL: URL(string: "https://xoqnfzwpizyulajvoohm.supabase.co")!,
            supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhvcW5mendwaXp5dWxhanZvb2htIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyMTM1OTAsImV4cCI6MjA1NDc4OTU5MH0.wUemS2y1JBgsNh-AaJEexlpaodPI-X67G7fCVygPZyg"
        )
    }
    
}
