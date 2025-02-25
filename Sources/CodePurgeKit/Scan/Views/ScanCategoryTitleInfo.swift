//
//  ScanCategoryTitleInfo.swift
//  
//
//  Created by Nikolai Nobadi on 1/4/25.
//

import SwiftUI

/// A view displaying the title and optional summary for a scan category.
struct ScanCategoryTitleInfo: View {
    let name: String
    let summary: String?
    
    /// Initializes the view with a category name and optional summary.
        /// - Parameters:
        ///   - name: The name of the scan category.
        ///   - summary: An optional summary of the scan category.
    init(_ name: String, summary: String? = nil) {
        self.name = name
        self.summary = summary
    }
    
    var body: some View {
        VStack {
            Text(name)
                .bold()
                .padding()
                .font(.title)
            
            if let summary {
                Text(summary)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
            }
        }
        .multilineTextAlignment(.center)
    }
}
