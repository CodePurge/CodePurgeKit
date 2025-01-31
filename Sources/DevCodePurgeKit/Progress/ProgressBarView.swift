//
//  ProgressBarView.swift
//
//
//  Created by Nikolai Nobadi on 1/24/25.
//

import SwiftUI

/// A view that displays a progress bar along with a title and progress information.
public struct ProgressBarView: View {
    let title: String
    let info: ProgressInfo
    let barColor: Color
    
    public init(_ title: String, info: ProgressInfo, barColor: Color = .softGreen) {
        self.title = title
        self.info = info
        self.barColor = barColor
    }
    
    public var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
            
            if info.canMakeProgress {
                VStack(spacing: 0) {
                    Text(info.percentText)
                        .bold()
                        .font(.title)
                    
                    FancyProgressBar(goal: info.totalProgress, progress: info.currentProgress, barColor: barColor)
                }
                .padding()
            } else {
                AnimatingProgressBar(barColor: barColor)
            }
        }
    }
}


// MARK: - Extension Dependencies
fileprivate extension ProgressInfo {
    var canMakeProgress: Bool {
        return totalProgress != 0
    }
}
