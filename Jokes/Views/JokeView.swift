//
//  JokeView.swift
//  Jokes
//
//  Created by Isaad Khan on 2023-04-18.
//

import SwiftUI

struct JokeView: View {
    
    // MARK: Stored properties
    @State var punchlineOpacity = 0.0
    
    // The current joke to display
    @State var currentJoke = exampleJoke
    
    // MARK: Computed properties
    var body: some View {
        NavigationView{
            VStack{
                Text(currentJoke.setup)
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    withAnimation(.easeIn(duration: 1.0)) {
                        punchlineOpacity = 1.0
                    }
                }, label:{
                    Image(systemName:"arrow.down.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .tint(.black)
                })
                
                Text(currentJoke.punchline)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .opacity(punchlineOpacity)
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
