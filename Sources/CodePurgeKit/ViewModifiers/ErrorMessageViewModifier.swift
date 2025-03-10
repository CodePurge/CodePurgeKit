//
//  ErrorMessageViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 3/10/25.
//

import SwiftUI

struct ErrorMessageViewModifier: ViewModifier {
    let error: ScanError?
    
    func body(content: Content) -> some View {
        if let error {
            VStack {
                Text(error.message)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            content
        }
    }
}

public extension View {
    func showingErrorMessage(_ error: ScanError?) -> some View {
        modifier(ErrorMessageViewModifier(error: error))
    }
}
