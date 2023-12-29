//
//  AudioRecorder.swift
//  RecordTest Watch App
//
//  Created by Péter Sanyó on 29.12.23.
//

import AVFoundation
import WatchKit
import SwiftUI

class AudioRecorder: NSObject, ObservableObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    var audioRecorder: AVAudioRecorder?
    let audioSession = AVAudioSession.sharedInstance()
    var audioPlayer: AVAudioPlayer?
    
    @Published var recordings: [URL] = []
    @Published var hasRecordingPermission: Bool = false
    @Published var isRecording = false
    
    @Published var recordingTime: TimeInterval = 0
    var recordingTimer: Timer?
    
    override init() {
        super.init()
        print("Initializing AudioRecorder")
        setupAudioSession()
        fetchRecordings()
    }

    func fetchRecordings() {
        print("Fetching recordings")
        let urls = try? FileManager.default.contentsOfDirectory(at: getDocumentsDirectory(), includingPropertiesForKeys: nil)
        recordings = urls?.filter { $0.pathExtension == "m4a" } ?? []
        print("Found \(recordings.count) recordings")
    }
    
    func setupAudioSession() {
        print("Setting up audio session")
        do {
            try audioSession.setCategory(.playAndRecord, mode: .voiceChat)
            try audioSession.setActive(true)
            AVAudioApplication.requestRecordPermission { [weak self] granted in
                DispatchQueue.main.async {
                    self?.hasRecordingPermission = granted
                    print("Recording permission granted: \(granted)")
                }
            }
        } catch {
            print("Audio session setup failed: \(error)")
        }
    }

    func startRecording() {
        print("Starting recording")
        let uniqueName = randomString(length: 3) + ".m4a"
        let audioFilename = getDocumentsDirectory().appendingPathComponent(uniqueName)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            withAnimation {
                isRecording = true
            }
            print("Recording started successfully")
        } catch {
            print("Could not start recording: \(error)")
        }
        startTimer()
    }
    
    func stopRecording() {
        print("Stopping recording")
        if let url = audioRecorder?.url, audioRecorder?.isRecording == true {
            recordings.append(url)  // Add the recording URL to the list
            print("Recording saved at \(url)")
        }
        audioRecorder?.stop()
        withAnimation {
            isRecording = false
        }
        stopTimer()
    }
    
    func playRecording(url: URL) {
        print("Playing recording at \(url)")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Playback failed: \(error.localizedDescription)")
        }
    }

    func startTimer() {
        print("Starting timer")
        recordingTimer?.invalidate() // Invalidate any existing timer
        recordingTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.recordingTime += 1
        }
    }

    func stopTimer() {
        print("Stopping timer")
        recordingTimer?.invalidate()
        recordingTimer = nil
        recordingTime = 0
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }

    func getDocumentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        print("Documents directory: \(path)")
        return path
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            isRecording = false
            print("Recording did not finish successfully")
        } else {
            print("Recording finished successfully")
        }
    }
    
    @objc func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            print("Playback finished successfully")
        } else {
            print("Playback finished unsuccessfully")
        }
    }

    @objc func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        if let error = error {
            print("Decode error occurred: \(error.localizedDescription)")
        } else {
            print("Decode error occurred without a specific error message")
        }
    }
}
