//
//  JokeView.swift
//  Jokes
//
//  Created by Isaad Khan on 2023-04-18.
//

import SwiftUI

struct JokeView: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("You see, mountains aren't just funny.")
                    .font(.title)
                    .multilineTextAlignment(.center)
            }
        }
        .navigationTitle("Random Jokes")
    }
}

struct JokeView_Previews: PreviewProvider {
    static var previews: some View {
        JokeView()
    }
}
