//
//  ScanResultView.swift
//
//
//  Created by Nikolai Nobadi on 1/4/25.
//

import SwiftUI

/// A view that displays the results of a scan operation, presenting scanned categories in a list or grid format.
/// Supports expanding categories into an overlay and integrates with the `PurgeIsLive` environment key.
public struct ScanResultView<Content: View, Delegate: ScanResultDelegate>: View {
    @Namespace private var namespace
    @State private var showingOverlay = false
    @State private var showingPurgeContent = false
    @State private var animateCategoryContent = false
    @Environment(\.purgeIsLive) private var isLive
    @Environment(\.openWindow) private var openWindow
    @Binding var selection: Delegate.CategoryInfo?
    
    let delegate: Delegate
    let content: (Delegate.CategoryInfo) -> Content
    
    /// Initializes the scan result view.
    /// - Parameters:
    ///   - selection: A binding to the currently selected category info, used for overlay transitions.
    ///   - delegate: A delegate conforming to `ScanResultDelegate`, responsible for providing scanned categories and handling restart actions.
    ///   - content: A closure that returns the detailed content view for a selected category.
    public init(selection: Binding<Delegate.CategoryInfo?>, delegate: Delegate, @ViewBuilder content: @escaping (Delegate.CategoryInfo) -> Content) {
        self._selection = selection
        self.delegate = delegate
        self.content = content
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            if !showingOverlay {
                HStack {
                    Button("Start Over", action: delegate.startOver)
                        .padding(.horizontal)
                        .buttonStyle(.rectPurgeStyle(gradient: .softRedGradient, font: .body, padding: 10))
                    Spacer()
                }
            }
            
            CategoryListContentView(categories: delegate.scannedCategories) { info in
                CategoryResultCard(info: info, isLive: isLive)
                    .heroExpanding(
                        item: info,
                        selection: $selection,
                        showingOverlay: $showingOverlay,
                        sizeInfo: info.makeHeroSizeInfo(count: delegate.scannedCategories.count),
                        namespace: namespace
                    )
                    .withShowDetailsInfoButton(categoryName: info.category.name, alignment: .topTrailing) {
                        openWindow(value: info.detailInfo)
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .heroOverlay(item: selection, isShowing: showingOverlay) { categoryInfo in
            HeroOverlayView(
                selection: $selection,
                showingOverlay: $showingOverlay,
                animateCategoryContent: $animateCategoryContent,
                isLive: isLive,
                categoryInfo: categoryInfo,
                namespace: namespace,
                content: content
            ) {
                openWindow(value: $0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .onAppear {
                withAnimation(.easeInOut.delay(0.2)) {
                    animateCategoryContent = true
                }
            }
        }
    }
}


// MARK: - ResultCard
fileprivate struct CategoryResultCard<Info: ScannedCategoryInfo>: View {
    let info: Info
    let isLive: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            ScanCategoryTitleInfo(info.category.name, summary: info.category.summary)
                .foregroundStyle(Color.purgeTint(isLive: isLive))
            
            Spacer()
            
            PurgeText(info.size)
                .bold()
                .font(.largeTitle)
                .foregroundStyle(Color.purgeTint(isLive: isLive))
            
            if info.selectedSize > 0 {
                HStack {
                    Text("Selected:")
                    PurgeText(info.selectedSize)
                        .font(.headline)
                        .foregroundStyle(Color.softRed)
                }
                .padding(.bottom, 5)
            }
        }
    }
}


// MARK: - OverlayView
fileprivate struct HeroOverlayView<Info: ScannedCategoryInfo, Content: View>: View {
    @Binding var selection: Info?
    @Binding var showingOverlay: Bool
    @Binding var animateCategoryContent: Bool
    
    let isLive: Bool
    let categoryInfo: Info
    let namespace: Namespace.ID
    let content: (Info) -> Content
    let openWindow: (PurgeCategoryDetailInfo) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ScanCategoryTitleInfo(categoryInfo.category.name)
                
                PurgeText(categoryInfo.size)
                    .bold()
                    .font(.title)
                    .foregroundStyle(Color.purgeTint(isLive: isLive))
            }
            .frame(maxWidth: .infinity)
            .overlay(alignment: .leading) {
                Button("Done") {
                    withAnimation(.smooth) {
                        showingOverlay = false
                        selection = nil
                    }
                }
                .padding(.horizontal)
            }
            .withShowDetailsInfoButton(categoryName: categoryInfo.name, alignment: .trailing) {
                openWindow(categoryInfo.detailInfo)
            }
            
            Group {
                if animateCategoryContent {
                    content(categoryInfo)
                        .padding()
                }
            }
            .matchedGeometryEffect(id: categoryInfo.id, in: namespace)
            .scaleEffect(animateCategoryContent ? 1 : 0.001, anchor: .leading)
            .transition(.opacity.animation(.smooth(duration: 0.5)))
        }
    }
}


// MARK: - ResultHeader
/// A view representing the header of a scanned category result.
fileprivate struct ScanResultHeaderView<Category: ScannedCategoryInfo>: View {
    let category: Category
    let isSelected: Bool
    let isLive: Bool

    var body: some View {
        VStack {
            if isSelected {
                HStack {
                    ScanCategoryTitleInfo(category.name)

                    PurgeText(category.size)
                        .bold()
                        .font(.title)
                        .foregroundStyle(Color.purgeTint(isLive: isLive))
                }
            } else {
                VStack {
                    Spacer()
                    ScanCategoryTitleInfo(category.name, summary: category.summary)
                    Spacer()

                    PurgeText(category.size)
                        .bold()
                        .font(.largeTitle)
                        .foregroundStyle(Color.purgeTint(isLive: isLive))
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isSelected)
    }
}


// MARK: - Dependencies
public protocol ScanResultDelegate {
    associatedtype CategoryInfo: ScannedCategoryInfo
    
    var scannedCategories: [CategoryInfo] { get }
    
    func startOver()
}


// MARK: - Extension Dependencies
fileprivate extension ScannedCategoryInfo {
    func makeHeroSizeInfo(count: Int) -> HeroExpandableSizeInfo {
        let heightMultiplier = count < 4 ? 1 : 0.8
        
        return .init(
            maxWidth: category.getWidth(totalCount: count),
            maxHeight: category.getHeight(totalCount: count) * heightMultiplier
        )
    }
}

// MARK: - Preview
#Preview {
    class PreviewDelegate: ScanResultDelegate {
        var scannedCategories: [MockInfo] { MockInfo.sampleList }
        func startOver() {}
    }
    
    return ScanResultView(selection: .constant(nil), delegate: PreviewDelegate(), content: { _ in Text("") })
}


// MARK: - Preview Helpers
struct MockCategory: ScannableCategory {
    let name: String
    var summary: String { "" }
    var detailInfo: PurgeCategoryDetailInfo { .init(title: "", description: "", details: [], guidance: [], tips: []) }
}

struct MockInfo: ScannedCategoryInfo {
    let size: Int64
    let selectedSize: Int64
    let category: MockCategory
    
    static var sampleList: [MockInfo] {
        return [
            .init(size: .baseSimulatorSize, selectedSize: .baseSimulatorSize, category: .init(name: "Archives")),
            .init(size: .baseSimulatorSize, selectedSize: .baseSimulatorSize, category: .init(name: "Derived Data")),
            .init(size: .baseSimulatorSize, selectedSize: .baseSimulatorSize, category: .init(name: "Device Support")),
            .init(size: .baseSimulatorSize, selectedSize: .baseSimulatorSize, category: .init(name: "Documentation Cache"))
        ]
    }
}
