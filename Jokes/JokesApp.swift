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
            JokeView()
            // Make the database available to all child views through the environment
                .environment(\.blackbirdDatabase, AppDatabase.instance)
        }
    }
}
