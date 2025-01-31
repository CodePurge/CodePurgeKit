//
//  TrailingSizeLabelViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/3/25.
//

import SwiftUI

struct TrailingSizeLabelViewModifier: ViewModifier {
    let prefix: String
    let size: Int64
    let withSpacer: Bool
    let boldSizeText: Bool
    
    private var prefixText: String {
        if prefix.isEmpty {
            return ""
        }
        
        return "\(prefix): "
    }
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            if withSpacer {
                Spacer()
            }
            
            Text("\(prefixText)\(size.toStorageSize)")
                .bold(boldSizeText)
                .padding(.horizontal)
        }
    }
}

public extension View {
    /// Adds a trailing label displaying a size value.
    ///
    /// - Parameters:
    ///   - prefix: The prefix text to display before the size value. Default is `"Purgable Memory"`.
    ///   - size: The size value to display.
    ///   - withSpacer: A Boolean indicating whether to add a spacer between content and the label. Default is `true`.
    ///   - boldSizeText: A Boolean indicating whether the size text should be bold. Default is `false`.
    func withTrailingSizeLabel(prefix: String = "Purgable Memory", size: Int64, withSpacer: Bool = true, boldSizeText: Bool = false) -> some View {
        modifier(TrailingSizeLabelViewModifier(prefix: prefix, size: size, withSpacer: withSpacer, boldSizeText: boldSizeText))
    }
}
