//
//  CategoryListContentView.swift
//
//
//  Created by Nikolai Nobadi on 1/27/25.
//

import SwiftUI

struct CategoryListContentView<Category: DisplayableCategory, Content: View>: View {
    let categories: [Category]
    let content: (Category) -> Content
    
    init(categories: [Category], @ViewBuilder content: @escaping (Category) -> Content) {
        self.categories = categories
        self.content = content
    }
    
    var body: some View {
        if categories.count <= 3 {
            HStack {
                ForEach(categories) { item in
                    content(item)
                }
            }
        } else {
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2),
                spacing: 16
            ) {
                ForEach(categories) { category in
                    content(category)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(
                        width: category.getWidth(totalCount: categories.count),
                        height: category.getHeight(totalCount: categories.count)
                    )
                }
            }
        }
    }
}


// MARK: - Dependencies
public protocol DisplayableCategory: Identifiable, Hashable { }

extension DisplayableCategory {
    func getWidth(totalCount: Int) -> CGFloat {
        return totalCount > 3 ? 400 : 300
    }
    
    func getHeight(totalCount: Int) -> CGFloat {
        return totalCount > 3 ? 200 : 300
    }
}
