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
    @EnvironmentObject var audioRecorder: AudioRecorder

    var body: some View {
//        if audioRecorder.hasRecordingPermission {
        ScrollView {
            VStack {
                ActionButton()
                Divider()
                QualityPicker()
                Divider()

                if audioRecorder.recordings.isEmpty {
                    Text("No recordings found")
                        .foregroundColor(.secondary)
                } else {
                    List {
                        ForEach(audioRecorder.recordings, id: \.self) { recording in
                            Button {
                                audioRecorder.playRecording(url: recording)
                            } label: {
                                HStack {
                                    Text(recording.lastPathComponent)
                                    Spacer()
                                    Image(systemName: "play.circle")
                                }
                            }
                        }
                        .onDelete(perform: delete)
                    }
                }
            }
        }
        .onAppear {
            audioRecorder.setupAudioSession()
            audioRecorder.fetchRecordings()
        }
//        } else {
//            Text("Recording permissions not granted. Please enable them in settings.")
//        }
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
