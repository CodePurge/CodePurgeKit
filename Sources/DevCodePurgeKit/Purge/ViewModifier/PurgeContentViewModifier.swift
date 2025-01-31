//
//  PurgeContentViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/28/25.
//

import SwiftUI

struct PurgeContentViewModifier<Delegate: PurgeContentDelegate, ButtonView: View>: ViewModifier {
    @Binding var purgeInfo: ConfirmPurgeInfo?
    @Environment(\.purgeIsLive) private var isLive
    
    let delegate: Delegate
    let buttonView: () -> ButtonView
    
    private func finished() {
        purgeInfo = nil
    }
    
    func body(content: Content) -> some View {
        ZStack {
            VStack {
                content
                
                Spacer()
                
                if delegate.canShowPurgeButtonView {
                    buttonView()
                        .withSelectionDetailFooter(
                            selectionCount: delegate.totalSelectedCount,
                            selectionSize: delegate.totalSelectedSize,
                            hideCount: delegate.hidePurgeCount
                        )
                }
            }
            
            if let purgeInfo {
                if isLive {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                    
                    PurgeContentView(viewModel: .init(info: purgeInfo, delegate: delegate, onFinished: finished))
                } else {
                    Text("")
                        .task {
                            let _ = try? await delegate.startPurge(progressDelegate: nil)
                            
                            await MainActor.run {
                                finished()
                            }
                        }
                }
            }
        }
    }
}

public extension View {
    /// Displays the purge content view as an overlay when `purgeInfo` is set.
    ///
    /// This extension applies a `PurgeContentViewModifier` to the view, which manages
    /// the presentation of purge-related content. The underlying view modifier utilizes
    /// the `PurgeIsLive` environment key to determine whether the purge should be executed
    /// in live mode or practice mode.
    ///
    /// - Parameters:
    ///   - purgeInfo: A binding to `ConfirmPurgeInfo?`, which controls whether the purge content is displayed.
    ///   - delegate: A delegate conforming to `PurgeContentDelegate`, responsible for handling purge actions.
    ///   - buttonView: A closure that returns the button view for initiating the purge.
    func showingPurgeContent<Delegate: PurgeContentDelegate, ButtonView: View>(purgeInfo: Binding<ConfirmPurgeInfo?>, delegate: Delegate, @ViewBuilder buttonView: @escaping () -> ButtonView) -> some View {
        modifier(PurgeContentViewModifier(purgeInfo: purgeInfo, delegate: delegate, buttonView: buttonView))
    }
}


// MARK: - Dependencies
public protocol PurgeContentDelegate: PurgeRecordDelegate {
    var hidePurgeCount: Bool { get }
    var totalSelectedCount: Int { get }
    var totalSelectedSize: Int64 { get }
    var canShowPurgeButtonView: Bool { get }
}

public extension PurgeContentDelegate {
    var hidePurgeCount: Bool { false }
}
