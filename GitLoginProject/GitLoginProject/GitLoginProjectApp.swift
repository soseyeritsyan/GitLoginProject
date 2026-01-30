//
//  GitLoginProjectApp.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 08.01.26.
//

import SwiftUI
import SwiftData

@main
struct GitLoginProjectApp: App {
    @StateObject private var authState: AuthenticationState
    
    init() {
        _authState = StateObject(
            wrappedValue: AuthenticationState()
        )
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authState)
        }
    }
}
