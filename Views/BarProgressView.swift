//
//  BarProgressView.swift
//  lisse
//
//  Created by sri on 22/04/25.
//

import SwiftUI

struct AudioProgressBar: View {
    @Binding var progress: Double
    var duration: Double
    var onSeek: (Double) -> Void

    var body: some View {
        VStack {
            Slider(
                value: $progress,
                in: 0...duration,
                onEditingChanged: { editing in
                    if !editing {
                        onSeek(progress)
                    }
                }
            )
            .accentColor(.blue)
            .padding(.horizontal)

            HStack {
                Text(formatTime(progress))
                Spacer()
                Text(formatTime(duration))
            }
            .font(.caption)
            .padding(.horizontal)
        }
    }

    private func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
