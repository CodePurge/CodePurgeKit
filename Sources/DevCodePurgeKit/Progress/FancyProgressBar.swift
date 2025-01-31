//
//  FancyProgressBar.swift
//
//
//  Created by Nikolai Nobadi on 1/22/25.
//

import SwiftUI

/// A custom progress bar view that visually represents progress towards a goal.
struct FancyProgressBar: View {
    let goal: Int
    let progress: Int
    let barColor: Color

    private var height: CGFloat {
        return 20
    }

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let progressWidth = CGFloat(progress) / CGFloat(goal) * width

            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: height, style: .continuous)
                    .frame(height: height)
                    .foregroundColor(Color.black.opacity(0.1))

                RoundedRectangle(cornerRadius: height, style: .continuous)
                    .fill(barColor)
                    .frame(width: progressWidth, height: height)
            }
        }
        .frame(height: height)
    }
}

