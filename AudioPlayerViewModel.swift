//
//  AudioPlayerViewModel.swift
//  lisse
//
//  Created by sri on 20/04/25.
//

import Foundation
import AVFoundation

class AudioPlayerViewModel: ObservableObject {
    @Published var audioPlayer: AVAudioPlayer?
    @Published var progress: Double = 0.0
    @Published var duration: Double = 1.0// evitar división por 0
    @Published var importedFileURLs: [URL] = []
    @Published var currentTrackIndex: Int? = nil
    @Published var isPlaying: Bool = false
    @Published var currentURL: URL?
    


    

    private var timer: Timer?

    func play(url: URL) {
        if url.startAccessingSecurityScopedResource() {
            defer { url.stopAccessingSecurityScopedResource() }

            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                isPlaying = true
                duration = audioPlayer?.duration ?? 1.0
                startTimer()

            } catch {
                print("Error al reproducir: \(error)")
            }
        }
    }

    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            if let player = self.audioPlayer, player.isPlaying {
                DispatchQueue.main.async {
                    self.progress = player.currentTime
                }
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func seek(to time: Double) {
        audioPlayer?.currentTime = time
        progress = time
    }
    
    
    func pause(){
        audioPlayer?.pause()
    }
    
    func resume(){
        audioPlayer?.play()
    }
    
    func stop(){
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
        progress = 0
        stopTimer()
    }
    
    func playNext() {
        guard let index = currentTrackIndex, index + 1 < importedFileURLs.count else { return }
        let nextIndex = index + 1
        currentTrackIndex = nextIndex
        play(url: importedFileURLs[nextIndex])
    }
    
    func playPrevious() {
        guard let index = currentTrackIndex, index > 0 else { return }
        let prevIndex = index - 1
        currentTrackIndex = prevIndex
        play(url: importedFileURLs[prevIndex])
    }
}


