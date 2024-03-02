//
//  ContentView.swift
//  BitsoShell
//
//  Created by Igor on 27/02/2024.
//

import BitsoNav
import BitsoUI
import SwiftUI

struct AppCoordinator: View {

    // MARK: Properties

    @ObservedObject var router = Router()

    // MARK: Body

    var body: some View {
        NavigationStack(path: $router.path) {
            RootView()
        }
        .environmentObject(router)
    }
}
