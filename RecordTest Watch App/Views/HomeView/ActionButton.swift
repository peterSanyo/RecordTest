//
//  ActionButton.swift
//  RecordTest Watch App
//
//  Created by Péter Sanyó on 30.12.23.
//

import SwiftUI

struct ActionButton: View {
    @StateObject var audioRecorder = AudioRecorder()

    var body: some View {
        Button {
            if audioRecorder.isRecording {
                audioRecorder.stopRecording()
            } else {
                audioRecorder.startRecording()
            }
        } label: {
            ZStack {
                actionShape
                    .foregroundColor(.red)
                        
                Text(audioRecorder.isRecording ? "Stop (\(Int(audioRecorder.recordingTime)))" : "Record")
                    .bold()
            }
        }
        .buttonStyle(PlainButtonStyle())
        .padding(20)
    }
    
    // MARK: - UI
    
    var actionShape: some View {
        Group {
            if audioRecorder.isRecording {
                Image(systemName: "square.fill")
                    .controlSize(/*@START_MENU_TOKEN@*/.regular/*@END_MENU_TOKEN@*/)
                    
            } else {
                Image(systemName: "largecircle.fill.circle")
            }
        }
    }
    
    // MARK: - Logic
    
    private func toggleRecording() {
        if audioRecorder.isRecording {
            audioRecorder.stopRecording()
        } else {
            audioRecorder.startRecording()
        }
    }
}

#Preview {
    ActionButton()
}
