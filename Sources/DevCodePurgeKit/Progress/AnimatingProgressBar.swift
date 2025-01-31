//
//  AnimatingProgressBar.swift
//
//
//  Created by Nikolai Nobadi on 1/24/25.
//

import SwiftUI

/// A custom progress bar view that animates to indicate loading is in progress.
struct AnimatingProgressBar: View {
    @State private var progress: CGFloat = 0
    @State private var phase: AnimationPhase = .fillingForward
    
    let barColor: Color
    
    private var height: CGFloat {
        return 20
    }

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let progressWidth = calculateWidth(for: width)
            let offsetX = calculateOffset(for: width)
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: height, style: .continuous)
                    .frame(height: height)
                    .foregroundColor(Color.black.opacity(0.1))
                
                RoundedRectangle(cornerRadius: height, style: .continuous)
                    .fill(barColor)
                    .frame(width: progressWidth, height: height)
                    .offset(x: offsetX)
            }
            .onAppear {
                startAnimation()
            }
        }
        .frame(height: height)
    }
}

// MARK: - Private Methods
private extension AnimatingProgressBar {
    func calculateWidth(for width: CGFloat) -> CGFloat {
        switch phase {
        case .fillingForward, .fillingBackward:
            return progress * width
        case .flowingForward, .flowingBackward:
            return (1 - progress) * width
        }
    }

    func calculateOffset(for width: CGFloat) -> CGFloat {
        switch phase {
        case .fillingForward, .flowingBackward:
            return 0
        case .flowingForward:
            return progress * width
        case .fillingBackward:
            return (1 - progress) * width
        }
    }

    func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.008, repeats: true) { timer in
            progress += 0.01

            if progress >= 1.0 {
                progress = 0
                phase = phase.next()
            }
        }
    }
}


// MARK: - Preview
#Preview {
    VStack {
        VStack {
            AnimatingProgressBar(barColor: .softGreen)
        }
        .frame(width: 200, height: 200)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}


// MARK: - Dependencies
private enum AnimationPhase: CaseIterable {
    case fillingForward
    case flowingForward
    case fillingBackward
    case flowingBackward

    func next() -> AnimationPhase {
        switch self {
        case .fillingForward: return .flowingForward
        case .flowingForward: return .fillingBackward
        case .fillingBackward: return .flowingBackward
        case .flowingBackward: return .fillingForward
        }
    }
}
