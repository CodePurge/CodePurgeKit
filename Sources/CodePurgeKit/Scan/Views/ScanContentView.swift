//
//  ScanContentView.swift
//
//
//  Created by Nikolai Nobadi on 1/3/25.
//

import SwiftUI

/// A view that displays content based on the current scan state.
/// Supports different views for not started, in progress, finished, and failed states.
public struct ScanContentView<Home: View, Result: View>: View {
    @Environment(\.purgeIsLive) private var isLive
    
    let delegate: ScanViewDelegate
    let home: () -> Home
    let result: () -> Result
    
    /// Initializes the scan state view.
    /// - Parameters:
    ///   - delegate: The delegate managing the scan state.
    ///   - home: A closure that provides the view for the not started state.
    ///   - result: A closure that provides the view for the finished state.
    public init(delegate: ScanViewDelegate, @ViewBuilder home: @escaping () -> Home, @ViewBuilder result: @escaping () -> Result) {
        self.delegate = delegate
        self.home = home
        self.result = result
    }
    
    public var body: some View {
        switch delegate.scanState {
        case .notStarted:
            home()
        case .inProgress(let scanDetails):
            VStack {
                ProgressBarView(
                    "Scanning \(scanDetails.category)",
                    info: scanDetails.progress,
                    barColor: .purgeTint(isLive: isLive)
                )
                
                GroupBox {
                    Text(scanDetails.progress.details)
                }
                .padding()
            }
            .frame(maxWidth: 500)
        case .finished:
            result()
        case .failed(let errorMessage):
            VStack {
                Text(errorMessage)
                    .padding()
                    .font(.title3)
                
                Button("Start Over", action: delegate.startOver)
            }
        }
    }
}


// MARK: - Dependencies
/// A protocol defining the delegate for managing scan states and related actions.
public protocol ScanViewDelegate {
    /// The current state of the scanning process.
    var scanState: ScanState { get }

    /// Restarts the scanning process.
    func startOver()
}
