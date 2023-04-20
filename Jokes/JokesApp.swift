//
//  JokesApp.swift
//  Jokes
//
//  Created by Isaad Khan on 2023-04-18.
//

import SwiftUI

@main
struct JokesApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                JokeView()
                    .tabItem{
                        Label("Fresh", systemImage: "carrot")
                    }
                FavouriteView()
                    .tabItem {
                        Label("Favourites", systemImage: "face.smiling")
                    }
            }
            .environment(\.blackbirdDatabase, AppDatabase.instance)
        }
        
    }
}
