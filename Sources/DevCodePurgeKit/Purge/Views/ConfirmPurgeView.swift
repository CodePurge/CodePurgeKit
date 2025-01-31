//
//  ConfirmPurgeView.swift
//  
//
//  Created by Nikolai Nobadi on 1/23/25.
//

import SwiftUI

/// A SwiftUI view that displays a confirmation prompt for starting or canceling a purge operation.
struct ConfirmPurgeView: View {
    let info: ConfirmPurgeInfo
    let startPurge: () -> Void
    let finishPurge: () -> Void
    
    var body: some View {
        VStack {
            Text(info.title)
                .padding()
                .font(.title)
            
            HStack {
                Text("\(info.itemType) count:")
                Text("\(info.itemCount)")
                    .bold()
                    .foregroundStyle(Color.softGreen)
            }
            
            HStack {
                Text("Purgable Memory:")
                PurgeText(info.purgableMemory)
                    .bold()
                    .foregroundStyle(Color.softGreen)
            }
            
            GroupBox {
                ForEach(info.details, id: \.self) { detail in
                    Text("- \(detail)")
                        .padding(.vertical, 1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
            .font(.headline)
            .foregroundStyle(Color.softRed)
            
            Button(info.buttonText, action: startPurge)
                .padding()
                .buttonStyle(.rectPurgeStyle(gradient: .softGreenGradient, padding: 10))
            
            Button("Cancel", action: finishPurge)
                .padding(.vertical, 30)
                .buttonStyle(.rectPurgeStyle(gradient: .softRedGradient, font: .body, padding: 5))
        }
    }
}


// MARK: - Preview
#Preview {
    ConfirmPurgeView(info: .init(title: "", itemType: "folders", itemCount: 10, purgableMemory: .baseSimulatorSize * 600, details: ["Items are moved to the trash bin, they are NOT deleted."], buttonText: "Let the Purge begin!"), startPurge: { }, finishPurge: { })
}
