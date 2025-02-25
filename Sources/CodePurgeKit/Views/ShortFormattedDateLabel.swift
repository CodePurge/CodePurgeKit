//
//  ShortFormattedDateLabel.swift
//
//
//  Created by Nikolai Nobadi on 1/3/25.
//

import SwiftUI

/// A view that displays a date formatted as a short string, optionally with a title.
///
/// The date is formatted using a short style for both date and time.
/// If a title is provided, it will be displayed alongside the formatted date.
///
/// - Note: The view uses a default text color of `.secondary`, which can be customized.
public struct ShortFormattedDateLabel: View {
    let date: Date?
    let title: String?
    let textColor: Color
    
    /// Initializes the view with the specified title, date, and text color.
    /// - Parameters:
    ///   - title: An optional title to display before the date. Default is `nil`.
    ///   - date: The date to display, formatted as a short string.
    ///   - textColor: The color of the text. Default is `.secondary`.
    public init(_ title: String?, date: Date?, textColor: Color = .secondary) {
        self.date = date
        self.title = title
        self.textColor = textColor
    }
    
    public var body: some View {
        if let date {
            HStack {
                if let title {
                    Text(title)
                }
                
                Text(date, formatter: DateFormatter.shortFormatter)
            }
            .font(.caption)
            .foregroundStyle(textColor)
        }
    }
}


// MARK: - Extension Dependencies
fileprivate extension DateFormatter {
    static var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}
