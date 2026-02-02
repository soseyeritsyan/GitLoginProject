//
//  MainTabView.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 26.01.26.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject private var authState: AuthenticationState
    
    var body: some View {
        TabView {
            
            RepositoriesView()
                .tabItem {
                    Label("Repos", systemImage: "folder")
                }
            
            AllUsersView()
                .tabItem {
                    Label("All Users", systemImage: "person")
                }
            
            MusicPlayerView()
                .tabItem {
                    Label("Music Player", systemImage: "person")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
    
}
