//
//  HomeViewModel.swift
//  Motive
//
//  Created by Michael Bautista on 5/11/25.
//

import SwiftUI
import SwiftData

@Observable
final class HomeViewModel {
    
    var quote = ""
    var source = ""
    var image = Data()
    
    var isLoading = false
    
}
