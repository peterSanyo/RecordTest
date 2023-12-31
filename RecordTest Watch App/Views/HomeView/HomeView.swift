//
//  HomeView.swift
//  RecordTest Watch App
//
//  Created by Péter Sanyó on 30.12.23.
//

import AVFoundation
import SwiftUI
import WatchKit

struct HomeView: View {
    @StateObject var audioRecorder = AudioRecorder()

    var body: some View {
//        if audioRecorder.hasRecordingPermission {
            ScrollView {
                VStack {
                    ActionButton(audioRecorder: audioRecorder)
                    Divider()
                    QualityPicker(audioRecorder: audioRecorder)
                    Divider()
                    fileList
                }
            }
            .onAppear {
                audioRecorder.setupAudioSession()
            }
//        } else {
//            Text("Recording permissions not granted. Please enable them in settings.")
//        }
    }

    // MARK: - UI

    var fileList: some View {
            ForEach(audioRecorder.recordings, id: \.absoluteURL) { recording in
                Button {
                    audioRecorder.playRecording(url: recording)
                } label: {
                    HStack {
                        Text(recording.lastPathComponent)
                        Spacer()
                        Image(systemName: "play.circle")
                    }
                }
                .padding(.horizontal)

            }
            .onDelete(perform: delete)
    }

    func delete(at offsets: IndexSet) {
        for index in offsets {
            let recording = audioRecorder.recordings[index]
            try? FileManager.default.removeItem(at: recording)
        }
        audioRecorder.recordings.remove(atOffsets: offsets)
    }
}

#Preview {
    HomeView()
        .environmentObject(AudioRecorder())
}
