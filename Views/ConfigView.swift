//
//  ConfigView.swift
//  lisse
//
//  Created by sri on 22/04/25.
//

import SwiftUI

struct ConfigView: View {
    @ObservedObject var audioPlayer = AudioPlayerViewModel()
    @State private var showingfileImporter = false

    var body: some View {
        ZStack {
            Color.clear

            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showingfileImporter = true
                    }) {
                        Image(systemName: "gear")
                            .font(.system(size: 20))
                            .padding()
                    }
                }
                Spacer()
            }
        }
        .sheet(isPresented: $showingfileImporter) {
            FileImporterView()
        }
    }
}

#Preview {
    ConfigView()
}

