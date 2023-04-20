//
//  FavouriteView.swift
//  Jokes
//
//  Created by Isaad Khan on 2023-04-20.
//

import Blackbird
import SwiftUI

struct FavouriteView: View {
    
    // MARK: Stored properties
    
    //The list of favourtie jokes
    @BlackbirdLiveModels({ db in
        try await Joke.read(from: db)
    }) var favouriteJokes
   
    // MARK: Computed properties
    var body: some View {
        NavigationView {
            List(favouriteJokes.results) { currentJoke in
                VStack(alignment: .leading) {
                    Text(currentJoke.setup)
                        .bold()
                    Text(currentJoke.punchline)
                }
            }
            .navigationTitle("Favourite Jokes")
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
        // Make te database available to this view in Xcode Previews
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
