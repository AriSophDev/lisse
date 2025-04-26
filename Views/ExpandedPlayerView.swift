//
//  ExpandedPlayerView.swift
//  lisse
//
//  Created by sri on 25/04/25.
//

import SwiftUI

struct ExpandedPlayerView: View {
    @ObservedObject var audioPlayer: AudioPlayerViewModel
    @Binding var isExpanded: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text(audioPlayer.currentURL?.lastPathComponent ?? "Sin canción")
                .font(.headline)
                .padding()

            ProgressView(value: audioPlayer.progress, total: audioPlayer.duration)
                .padding(.horizontal)

            HStack(spacing: 40) {
                Button(action: audioPlayer.playPrevious) {
                    Image(systemName: "backward.fill")
                        .font(.largeTitle)
                }

                Button(action: {
                    if audioPlayer.audioPlayer?.isPlaying == true {
                        audioPlayer.pause()
                    } else {
                        audioPlayer.resume()
                    }
                }) {
                    Image(systemName: audioPlayer.audioPlayer?.isPlaying == true ? "pause.fill" : "play.fill")
                        .font(.largeTitle)
                }

                Button(action: audioPlayer.playNext) {
                    Image(systemName: "forward.fill")
                        .font(.largeTitle)
                }
            }

            Button("Cerrar") {
                isExpanded = false
            }
            .padding(.top)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ExpandedPlayerView(
        audioPlayer: AudioPlayerViewModel(),
        isExpanded: .constant(true)
    )
}

