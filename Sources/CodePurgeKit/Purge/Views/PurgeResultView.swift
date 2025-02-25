//
//  PurgeResultView.swift
//
//
//  Created by Nikolai Nobadi on 1/22/25.
//

import SwiftUI

struct PurgeResultView: View {
    let record: PurgeRecord
    let finishPurge: () -> Void
    
    var body: some View {
        VStack {
            Text("You survived the Purge!")
                .padding()
                .font(.largeTitle)
            
            VStack(alignment: .leading) {
                PurgeRowText(info: record.itemInfo, isSimulator: false)
                PurgeRowText(info: record.simulatorInfo, isSimulator: true)
            }
            .padding()
            
            if let totalSize = record.totalSize {
                GroupBox {
                    HStack {
                        Text("Total Memory Purged:")
                            .font(.headline)
                        PurgeText(totalSize)
                            .font(.title)
                            .foregroundStyle(Color.softRed)
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            
            Button("Done", action: finishPurge)
                .padding()
                .buttonStyle(.circlePurgeStyle(isLive: true))
        }
    }
}


// MARK: - RowText
fileprivate struct PurgeRowText: View {
    let info: ResultInfo
    let isSimulator: Bool
    
    private var prefix: String {
        return isSimulator ? "Erased data from" : "Deleted"
    }
    
    private var itemName: String {
        return isSimulator ? "simulator" : "item"
    }
    
    var body: some View {
        if info.count > 0 {
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text("\(prefix) ")
                Text("\(info.count)")
                    .bold()
                    .font(.title2)
                    .foregroundStyle(Color.softGreen)
                
                Text(" \(itemName.configurePlural(count: info.count)), purging ")
                PurgeText(info.size)
                    .bold()
                    .font(.title2)
                    .foregroundStyle(Color.softGreen)
            }
            .font(.title3)
        }
    }
}


// MARK: - Preview
#Preview {
    VStack {
        PurgeResultView(record: .sample, finishPurge: { })
            .frame(maxWidth: 500, maxHeight: 250)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}

extension PurgeRecord {
    static var sample: PurgeRecord {
        return .init(
            date: .now,
            itemInfo: .init(size: .baseSimulatorSize * 120, count: 10),
            simulatorInfo: .init(size: .baseSimulatorSize * 300, count: 20)
        )
    }
}
