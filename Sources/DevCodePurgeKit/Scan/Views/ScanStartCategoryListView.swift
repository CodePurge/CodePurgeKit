//
//  ScanStartCategoryListView.swift
//  
//
//  Created by Nikolai Nobadi on 1/4/25.
//

import SwiftUI

/// A view for displaying and selecting scan categories, with a button to start the scan.
///
/// This view utilizes the `purgeIsLive` environment key to determine whether the app
/// is in live mode. The live mode affects the appearance of certain elements, such as
/// the button and category tint colors.
public struct ScanStartCategoryListView<Category: ScannableCategory>: View {
    @State private var isPressed: Bool = false
    @Environment(\.purgeIsLive) private var isLive
    @Environment(\.openWindow) private var openWindow

    let options: [Category]
    let selections: Set<Category>
    let toggleScanCategory: (Category) -> Void
    let startScan: () -> Void

    /// Initializes the scan start category list view.
    /// - Parameters:
    ///   - options: The list of available categories to display for selection.
    ///   - selections: The set of currently selected categories.
    ///   - toggleScanCategory: The action to toggle the selection state of a category.
    ///   - startScan: The action to start the scan process.
    public init(options: [Category], selections: Set<Category>, toggleScanCategory: @escaping (Category) -> Void, startScan: @escaping () -> Void) {
        self.options = options
        self.selections = selections
        self.toggleScanCategory = toggleScanCategory
        self.startScan = startScan
    }

    public var body: some View {
        VStack {
            Spacer()
            
            CategoryListContentView(categories: options) { category in
                CategoryCard(
                    category: category,
                    isLive: isLive,
                    isSelected: selections.contains(category),
                    totalCount: options.count,
                    toggleCategory: toggleScanCategory
                )
                .withShowDetailsInfoButton(categoryName: category.name, alignment: .topTrailing) {
                    openWindow(value: category.detailInfo)
                }
            }
            
            Spacer()
            
            Button("Scan", action: startScan)
                .padding(.bottom, 30)
                .buttonStyle(.circlePurgeStyle(isLive: isLive))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


// MARK: - CategoryCard
fileprivate struct CategoryCard<Category: ScannableCategory>: View {
    let category: Category
    let isLive: Bool
    let isSelected: Bool
    let totalCount: Int
    let toggleCategory: (Category) -> Void
    
    var body: some View {
        VStack {
            ScanCategoryTitleInfo(category.name, summary: category.summary)
                .foregroundStyle(Color.purgeTint(isLive: isLive))
        }
        .frame(
            width: category.getWidth(totalCount: totalCount),
            height: category.getHeight(totalCount: totalCount)
        )
        .background()
        .clipShape(.rect(cornerRadius: 20))
        .overlay(alignment: .topLeading) {
            Text("Scan")
                .withCheckboxSelection(isSelected: isSelected, trailingPadding: 0) {
                    toggleCategory(category)
                }
                .padding()
        }
    }
}



// MARK: - Preview
#Preview("Test Mode") {
    ScanStartCategoryListView(options: PreviewScannableCategory.sampleList, selections: .init(), toggleScanCategory: { _ in }, startScan: { })
        .environment(\.purgeIsLive, false)
}

#Preview("Live Mode") {
    ScanStartCategoryListView(options: PreviewScannableCategory.sampleList, selections: .init(), toggleScanCategory: { _ in }, startScan: { })
        .environment(\.purgeIsLive, true)
}


// MARK: - Preview Helpers
struct PreviewScannableCategory: ScannableCategory {
    let id: String
    let name: String
    let summary: String
    var detailInfo: PurgeCategoryDetailInfo {
        return .init(title: "", description: "", details: [], guidance: [], tips: [])
    }
}

extension PreviewScannableCategory {
    static var sampleList: [PreviewScannableCategory] {
        return [
            .init(id: "0", name: "Archives", summary: "This is the summary for Archives"),
            .init(id: "1", name: "Derived Data", summary: "This is the summary for Derived Data"),
            .init(id: "2", name: "Documentation Cache", summary: "This is the summary for Archives"),
            .init(id: "3", name: "Device Support", summary: "This is the summary for Derived Data")
        ]
    }
}
