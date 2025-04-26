//
//  HomeView.swift
//  lisse
//
//  Created by sri on 24/04/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject  var audioPlayer = AudioPlayerViewModel()
    @Binding var isExpanded : Bool

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                // Botón de configuración arriba a la derecha
                HStack {
                    Spacer()
                    ConfigView(audioPlayer: audioPlayer)
                }
                .padding([.top, .trailing])

                // Lista de canciones importadas
                List {
                    ForEach(audioPlayer.importedFileURLs, id: \.self) { url in
                        Button(action: {
                            audioPlayer.play(url: url)
                        }) {
                            Text(url.lastPathComponent)
                        }
                    }
                }

                Spacer(minLength: 60) // espacio para el mini player
            }

            // MiniPlayer fijo abajo
            if audioPlayer.currentURL != nil {
                MiniPlayerView(audioPlayer: audioPlayer, isExpanded: $isExpanded)
                    .padding(.bottom, 8)
            }
        }
        // ExpandedPlayerView se abre como hoja
        .sheet(isPresented: $isExpanded) {
            ExpandedPlayerView(audioPlayer: audioPlayer, isExpanded: $isExpanded)
        }
    }
}

