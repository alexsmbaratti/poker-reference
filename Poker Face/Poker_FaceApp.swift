//
//  Poker_FaceApp.swift
//  Poker Face
//
//  Created by Alex Baratti on 12/11/22.
//

import SwiftUI

@main
struct Poker_FaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
#if os(visionOS)
                .frame(minWidth: 850, minHeight: 850)
#endif
        }
#if os(visionOS)
        .windowResizability(.contentSize)
#endif
#if os(visionOS)
        WindowGroup(id: "quick-reference") {
            QuickReferenceView(isShowing: .constant(true))
        }
#endif
    }
}
