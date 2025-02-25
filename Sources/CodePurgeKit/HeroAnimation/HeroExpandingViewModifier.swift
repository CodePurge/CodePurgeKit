//
//  HeroExpandingViewModifier.swift
//  
//
//  Created by Nikolai Nobadi on 1/14/25.
//

import SwiftUI

struct HeroExpandingViewModifier<Item: HeroAnimatable>: ViewModifier {
    @Binding var selection: Item?
    @Binding var showingOverlay: Bool
    @State private var isExpanding = false
    
    let item: Item
    let sizeInfo: HeroExpandableSizeInfo
    let namespace: Namespace.ID

    func body(content: Content) -> some View {
        Group {
            if !(item.id == selection?.id && showingOverlay) {
                content
                    .matchedGeometryEffect(id: item.id, in: namespace)
                    .frame(width: sizeInfo.maxWidth, height: sizeInfo.maxHeight)
                    .background(Color.darkSoftGray)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .scaleEffect(isExpanding ? 1.5 : 1)
                    .opacity(isExpanding ? 0.9 : 1)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                    .zIndex(isExpanding ? 1 : 0)
                    .onTapGesture {
                        selection = item
                        withAnimation(.smooth) {
                            isExpanding = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Delayed expansion
                            withAnimation(.smooth(duration: 0.4)) {
                                showingOverlay = true
                            }
                        }
                    }
            } else {
                Rectangle()
                    .foregroundStyle(.clear)
                    .frame(width: sizeInfo.maxWidth, height: sizeInfo.maxHeight)
            }
        }
        .onChange(of: selection) { newValue in
            if newValue == nil {
                withAnimation(.smooth) {
                    isExpanding = false
                }
            }
        }
    }
}

public extension View {
    /// Adds a hero-style expanding animation to a view, transitioning it to an overlay.
    /// - Parameters:
    ///   - item: The item that triggers the animation and overlay.
    ///   - selection: A binding to the currently selected item, used to manage the state of the animation.
    ///   - showingOverlay: A binding that controls whether the overlay is visible.
    ///   - namespace: The namespace for the matched geometry effect, enabling smooth transitions between views.
    func heroExpanding<Item: HeroAnimatable>(item: Item, selection: Binding<Item?>, showingOverlay: Binding<Bool>, sizeInfo: HeroExpandableSizeInfo, namespace: Namespace.ID) -> some View {
        modifier(HeroExpandingViewModifier(selection: selection, showingOverlay: showingOverlay, item: item, sizeInfo: sizeInfo, namespace: namespace))
    }
}

public struct HeroExpandableSizeInfo {
    public let maxWidth: CGFloat
    public let maxHeight: CGFloat
    
    public init(maxWidth: CGFloat, maxHeight: CGFloat) {
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
    }
}
