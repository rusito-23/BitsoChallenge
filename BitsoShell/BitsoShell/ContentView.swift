//
//  ContentView.swift
//  BitsoShell
//
//  Created by Igor on 27/02/2024.
//

import BitsoUI
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: Spacing.small.rawValue) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
