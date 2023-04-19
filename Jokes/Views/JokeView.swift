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
    @State var currentJoke: Joke?
    
    // MARK: Computed properties
    var body: some View {
        NavigationView{
            VStack{
                
                Spacer()
                
                if let currentJoke = currentJoke {
                    
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
                    
                    
                    // Show the joke, if it can be unwrapped (if currentJoke is not nil)
                } else {
                    // Show a spinning wheel indicator untill the joke is loaded
                    ProgressView()
                }
                    
                Spacer()
                
                Button(action :{
                    // Reset the interface
                    punchlineOpacity = 0.0
                    
                    Task{
                        // Get another joke
                        withAnimation{
                            currentJoke = nil
                        }
                        currentJoke = await NetworkService.fetch()
                        
                    }
                    
                }, label: {
                    Text("Fetch another one")
                    
                })
                .disabled(punchlineOpacity == 0.0 ? true: false)
                .buttonStyle(.borderedProminent)
                // Create an asynchronous task to be performed as this view appears
                
            }
            .task {
                currentJoke = await NetworkService.fetch()
            }
            .navigationTitle("Random Jokes")
        }
        
    }
}
    struct JokeView_Previews: PreviewProvider {
        static var previews: some View {
            JokeView()
        }
    }

