//
//  JokeView.swift
//  Jokes
//
//  Created by Isaad Khan on 2023-04-18.
//

import Blackbird
import SwiftUI

struct JokeView: View {
    
    // MARK: Stored properties
    
    // Access the connection to the database (needed to add a new record)
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    @State var punchlineOpacity = 0.0
    
    // The current joke to display
    @State var currentJoke: Joke?
    
    // Trach whether the current joke has been saved to database
    @State var savedToDatabase = false
    
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
                        
                        // Reset so that button to allow saving new joke to database is enabled
                        savedToDatabase = false
                    }
                    
                }, label: {
                    Text("Fetch another one")
                    
                })
                .disabled(punchlineOpacity == 0.0 ? true: false)
                .buttonStyle(.borderedProminent)
                // Create an asynchronous task to be performed as this view appears
                
                Button(action: {
                    Task{
                        // Write to database
                        if let currentJoke = currentJoke {
                            try await db!.transaction { core in
                                try core.query("INSERT INTO Joke (id, type, setup, punchline) VALUES (?, ?, ?, ?)",
                                               currentJoke.id,
                                               currentJoke.type,
                                               currentJoke.setup,
                                               currentJoke.punchline)
                                
                                // Record that this joke has been saved
                                savedToDatabase = true
                                
                            }
                        }
                    }
                }, label: {
                    Text("Save for later")
                })
                // Diable button until punchile is shown
                .disabled(punchlineOpacity == 0.0 ? true : false)
                // Once saved, disable the button so we can't save the joke twice
                .disabled(savedToDatabase == true ? true : false)
                // Use another colour to differentiate from first button
                .tint(.green)
                .buttonStyle(.borderedProminent)
                
            }
            .task {
                if currentJoke == nil {
                    currentJoke = await NetworkService.fetch()
                }
            }
            .navigationTitle("Random Jokes")
        }
        
    }
}
    struct JokeView_Previews: PreviewProvider {
        static var previews: some View {
            JokeView()
            //Make the database available to this view in Xcode Previews
                .environment(\.blackbirdDatabase, AppDatabase.instance)
        }
    }

