//
//  RowWithHeader.swift
//  Motive
//
//  Created by Michael Bautista on 4/30/25.
//

import SwiftUI

struct RowWithHeader<Content: View>: View {
    
    var header: String
    var content: () -> Content
    
    init(header: String, @ViewBuilder content: @escaping () -> Content) {
        self.header = header
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(header)
                .font(Font.FontStyles.footnote)
                .foregroundStyle(Color.ColorSystem.systemGray)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
            
            content()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    RowWithHeader(header: "Test") {
        Text("Test")
    }
}
