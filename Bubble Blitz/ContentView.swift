//
//  ContentView.swift
//  Bubble Blitz
//
//  Created by Tlaitirang Rathete on 29/4/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var playerName: String = ""
    //Add for highscore for userdeafult
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(.black)
                    .ignoresSafeArea()
                
                VStack {
                    Label("Bubble Blitz!", systemImage: "balloon.2.fill")
                        .foregroundStyle(.mint)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                    
                    NavigationLink(
                        destination: SettingsView(),
                        label: {Text("New Game")
                                .font(.title)
                                .foregroundStyle(.regularMaterial)
                                .padding()
                                .background(Color.blue) // Added background color to the button
                                .cornerRadius(10) // Added rounded corners
                        })
                    .padding(50)
                    
                    NavigationLink(
                        destination: HighScoreView(playerName: playerName, score: 0),
                        label: {Text("High Score")
                                .font(.title)
                                .foregroundStyle(.regularMaterial)
                                .padding()
                                .background(Color.green) // Added a different background color
                                .cornerRadius(10) // Added rounded corners
                        })
                    
                }
                .padding()
            }
            
        }
    }
}
#Preview {
    ContentView()
}
