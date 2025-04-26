//
//  MiniPlayerView.swift
//  lisse
//
//  Created by sri on 22/04/25.
//

import SwiftUI

struct MiniPlayerView: View {
    @ObservedObject var audioPlayer: AudioPlayerViewModel
    @Binding var isExpanded: Bool

    var body: some View {
        Group {
            if let currentURL = audioPlayer.currentURL {
                Button(action: {
                    isExpanded = true
                }) {
                    HStack {
                        Text(currentURL.lastPathComponent)
                            .lineLimit(1)
                            .font(.footnote)

                        Spacer()

                        Button(action: {
                            if audioPlayer.audioPlayer?.isPlaying == true {
                                audioPlayer.pause()
                            } else {
                                audioPlayer.resume()
                            }
                        }) {
                            Image(systemName: audioPlayer.audioPlayer?.isPlaying == true ? "pause.fill" : "play.fill")
                                .font(.title2)
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                }
            } else {
                EmptyView()
            }
        }
    }
}


#Preview {
    MiniPlayerView(
        audioPlayer: AudioPlayerViewModel(),
        isExpanded: .constant(false)
    )
}


