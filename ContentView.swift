//
//  ContentView.swift
//  lisse
//
//  Created by sri on 20/04/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isExpanded = false
    
    var body: some View {
        ZStack {
            #if os(iOS)
            Color.black.ignoresSafeArea()
            #else
            Color.gray.opacity(0.2).ignoresSafeArea()
            #endif
            
            HomeView(isExpanded: $isExpanded)
            
        }
    }
}
