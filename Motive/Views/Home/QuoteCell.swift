//
//  QuoteCell.swift
//  Motive
//
//  Created by Michael Bautista on 5/14/25.
//

import SwiftUI

struct QuoteCell: View {
    
    var quote: String
    var source: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(quote)
                .font(Font.FontStyles.title2)
                .foregroundStyle(Color.ColorSystem.primaryText)
            
            Text(source)
                .font(Font.FontStyles.headline)
                .foregroundStyle(Color.ColorSystem.systemGray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        .background(Color.ColorSystem.systemGray6)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    QuoteCell(quote: "Test", source: "Test")
}
