//
//  ContentView.swift
//  RecordTest Watch App
//
//  Created by Péter Sanyó on 29.12.23.
//
import AVFoundation
import SwiftUI
import WatchKit

struct ContentView: View {
    @StateObject var audioRecorder = AudioRecorder()

    var body: some View {
        VStack {
            if audioRecorder.hasRecordingPermission {
                Button {
                    audioRecorder.isRecording ? audioRecorder.stopRecording() : audioRecorder.startRecording()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: audioRecorder.isRecording ? 10 : 500)
                            .strokeBorder(.white)
                        
                        RoundedRectangle(cornerRadius: audioRecorder.isRecording ? 10 : 500)
                            .fill(Color.red)
                            .padding(4)
                    }
                }
            } else {
                // UI when permissions are not granted
                Text("Recording permissions not granted. Please enable them in settings.")
            }

            // ... rest of your UI ...
        }
        .padding(16)
        .onAppear {
            audioRecorder.setupAudioSession()
        }
    }
}

#Preview {
    ContentView()
}
