//
//  PurgeContentView.swift
//
//
//  Created by Nikolai Nobadi on 1/23/25.
//

import SwiftUI

/// A SwiftUI view that manages and displays the content of the purge operation.
struct PurgeContentView: View {
    @StateObject var viewModel: PurgeContentViewModel
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
                .roundedList()
            
            Group {
                switch viewModel.state {
                case .initial(let info):
                    ConfirmPurgeView(info: info, startPurge: viewModel.startPurge, finishPurge: viewModel.finishPurge)
                case .inProgress(let info):
                    PurgeProgressView(info: info)
                case .finished(let record):
                    if let record {
                        PurgeResultView(record: record, finishPurge: viewModel.finishPurge)
                    } else {
                        VStack {
                            Text("Purge Failed")
                                .font(.largeTitle)
                            
                            Button("Okay", action: viewModel.finishPurge)
                                .padding()
                                .buttonStyle(.rectPurgeStyle(gradient: .softRedGradient, padding: 10))
                        }
                    }
                }
            }
            .frame(maxWidth: 500, maxHeight: 500)
            .background(.thinMaterial)
            .roundedList()
        }
    }
}


// MARK: - Preview
//#Preview {
//    class PreviewDelegate: PurgeRecordDelegate {
//        var totalSelectedCount: Int { 5 }
//        var totalSelectedSize: Int64 { .baseSimulatorSize * 50 }
//        func saveRecord(_ record: PurgeRecord) async throws { }
//        func startPurge(progressDelegate: ProgressInfoDelegate?) async throws -> PurgeRecord? { nil }
//    }
//    
//    return ZStack {
//        HStack {
//            RoundedRectangle(cornerRadius: 10)
//                .frame(width: 150, height: 150)
//            RoundedRectangle(cornerRadius: 10)
//                .frame(width: 150, height: 150)
//            RoundedRectangle(cornerRadius: 10)
//                .frame(width: 150, height: 150)
//        }
//        
//        PurgeContentView(viewModel: .init(delegate: PreviewDelegate(), onFinished: { }))
//    }
//}
