//
//  PurgeProgressView.swift
//
//
//  Created by Nikolai Nobadi on 1/22/25.
//

import SwiftUI

/// A SwiftUI view that displays the progress of a purge operation.
struct PurgeProgressView: View {
    let info: ProgressInfo
    
    var body: some View {
        VStack {
            ProgressBarView("Purge in Progress", info: info)
            
            HStack {
                Text("Purging")
                GroupBox {
                    Text(info.details)
                }
            }
            .padding()
        }
    }
}


// MARK: - Preview
#Preview("Folder") {
    VStack {
        PurgeProgressView(info: .sampleFolderInfo)
            .frame(maxWidth: 300, maxHeight: 200)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}

#Preview("Simulator") {
    VStack {
        PurgeProgressView(info: .sampleSimulatorInfo)
            .frame(maxWidth: 300, maxHeight: 200)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}


// MARK: - Preview Helpers
extension ProgressInfo {
    static var sampleFolderInfo: ProgressInfo {
        return .init(details: "MyProjectArchive-January", currentProgress: 13, totalProgress: 28)
    }
    
    static var sampleSimulatorInfo: ProgressInfo {
        return .init(details: "iPhone 8", currentProgress: 15, totalProgress: 16)
    }
}
