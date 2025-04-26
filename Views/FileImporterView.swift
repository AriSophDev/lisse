//
//  FileImporterView.swift
//  lisse
//
//  Created by sri on 20/04/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct FileImporterView: View {
    @State private var showingFileImporter = false
    @State private var importedFileURLs: [URL] = []

    @StateObject private var audioPlayer = AudioPlayerViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Button("Importar Música") {
                showingFileImporter = true
            }
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 15))

            List(importedFileURLs, id: \.self) { url in
                Button(action: {
                    audioPlayer.play(url: url)
                }) {
                    Text(url.lastPathComponent)
                        .foregroundColor(.primary)
                }
            }

            // Solo si hay audio cargado
            if audioPlayer.audioPlayer != nil {
                VStack {
                    // Barra modularizada
                    AudioProgressBar(
                        progress: $audioPlayer.progress,
                        duration: audioPlayer.duration,
                        onSeek: { time in
                            audioPlayer.seek(to: time)
                        }
                    )

                    // Solo botón de Play/Pause
                    Button(action: {
                        if let player = audioPlayer.audioPlayer {
                            if player.isPlaying {
                                audioPlayer.pause()
                            } else {
                                audioPlayer.resume()
                            }
                        }
                    }) {
                        Image(systemName: audioPlayer.audioPlayer?.isPlaying == true ? "pause.fill" : "play.fill")
                            .font(.system(size: 36))
                            .padding()
                    }
                }
            }
        }
        .padding()
        .fileImporter(
            isPresented: $showingFileImporter,
            allowedContentTypes: [.audio],
            allowsMultipleSelection: true
        ) { result in
            switch result {
            case .success(let urls):
                importedFileURLs.append(contentsOf: urls)
            case .failure(let error):
                print("Error al importar archivos: \(error.localizedDescription)")
            }
        }
    }
}

    









