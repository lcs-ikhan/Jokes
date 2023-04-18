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
    
    // MARK: Computed properties
    var body: some View {
        NavigationView{
            VStack{
                Text("You see, mountains aren't just funny.")
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    punchlineOpacity = 1.0
                    
                }, label:{
                    Image(systemName:"arrow.down.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .tint(.black)
                })
                
                Text("They are hill areas.")
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
