//
//  WidgetPreviews.swift
//  Motive
//
//  Created by Michael Bautista on 5/6/25.
//

import SwiftUI

// MARK: Medium
struct MediumWidgetPreview: View {
    
    @Binding var quote: String
    @Binding var source: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("MEDIUM")
                .font(Font.FontStyles.footnote)
                .foregroundStyle(Color.ColorSystem.systemGray)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
            
            VStack(alignment: .leading, spacing: 5) {
                Text(
                    quote == "" ? "Circumstances don't make the man, they only reveal him to himself." : quote
                )
                .font(.custom("InterDisplay-Bold", size: 16))
                .foregroundStyle(Color.white)
                .lineLimit(5)
                
                Text(
                    source == "" ? "Epictetus" : source
                )
                .font(.custom("InterDisplay-Bold", size: 14))
                .foregroundStyle(Color.gray)
            }
            .frame(height: 155)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.ColorSystem.systemGray5)
            )
        }
    }
}

// MARK: Small
struct SmallWidgetPreview: View {
    
    @Binding var quote: String
    @Binding var source: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("SMALL")
                .font(Font.FontStyles.footnote)
                .foregroundStyle(Color.ColorSystem.systemGray)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
            VStack(alignment: .leading, spacing: 5) {
                Text(
                    quote == "" ? "Circumstances don't make the man, they only reveal him to himself." : quote
                )
                .font(.custom("InterDisplay-Bold", size: 14))
                .foregroundStyle(Color.white)
                .lineLimit(5)
                
                Text(
                    source == "" ? "Epictetus" : source
                )
                .font(.custom("InterDisplay-Bold", size: 12))
                .foregroundStyle(Color.gray)
                .lineLimit(1)
            }
            .frame(height: 155)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.ColorSystem.systemGray5)
            )
        }
    }
}

struct LockScreenWidgetPreview: View {
    
    @Binding var quote: String
    @Binding var source: String
    
    var body: some View {
        // MARK: Lock screen
        VStack(alignment: .leading, spacing: 5) {
            Text("LOCK SCREEN")
                .font(Font.FontStyles.footnote)
                .foregroundStyle(Color.ColorSystem.systemGray)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
            
            VStack(alignment: .leading, spacing: 0) {
                Text(
                    source == "" ? "Epictetus" : source
                )
                .font(.custom("InterDisplay-Bold", size: 12))
                .foregroundStyle(Color.white)
                .lineLimit(1)
                
                Text(
                    quote == "" ? "Circumstances don't make the man, they only reveal him to himself." : quote
                )
                .font(.custom("InterDisplay", size: 10))
                .foregroundStyle(Color.white)
                .lineLimit(3)
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.ColorSystem.systemGray5)
            )
        }
    }
}

#Preview {
    MediumWidgetPreview(quote: .constant("Quote"), source: .constant("Source"))
    SmallWidgetPreview(quote: .constant("Quote"), source: .constant("Source"))
    LockScreenWidgetPreview(quote: .constant("Quote"), source: .constant("Source"))
}
