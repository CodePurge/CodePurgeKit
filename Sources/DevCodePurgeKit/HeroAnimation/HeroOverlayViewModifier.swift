//
//  HeroOverlayViewModifier.swift
//
//
//  Created by Nikolai Nobadi on 1/14/25.
//

import SwiftUI

struct HeroOverlayViewModifier<Item: HeroAnimatable, Overlay: View>: ViewModifier {
    let item: Item?
    let isShowing: Bool
    let overlayView: (Item) -> Overlay
    
    init(item: Item?, isShowing: Bool, @ViewBuilder overlay: @escaping (Item) -> Overlay) {
        self.item = item
        self.isShowing = isShowing
        self.overlayView = overlay
    }

    func body(content: Content) -> some View {
        content
            .overlay {
                if let item, isShowing {
                    overlayView(item)
                        .padding(.top)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.darkSoftGray)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal)
                        .transition(
                            .asymmetric(
                                insertion: .opacity.combined(with: .scale(scale: 1.0)).animation(.easeInOut(duration: 0.6)),
                                removal: .opacity.combined(with: .scale(scale: 0.8)).animation(.easeInOut(duration: 0.4))
                            )
                        )
                }
            }
    }
}


public extension View {
    /// Adds an overlay to a view with a hero-style animation.
    /// - Parameters:
    ///   - item: The optional item that triggers the overlay. If `nil`, the overlay is not displayed.
    ///   - isShowing: A Boolean indicating whether the overlay is visible.
    ///   - overlay: A closure that provides the overlay view based on the given item.
    func heroOverlay<Item: HeroAnimatable, Overlay: View>(item: Item?, isShowing: Bool, @ViewBuilder overlay: @escaping (Item) -> Overlay) -> some View {
        modifier(HeroOverlayViewModifier(item: item, isShowing: isShowing, overlay: overlay))
    }
}
