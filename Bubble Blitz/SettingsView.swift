//
//  SettingsView.swift
//  Bubble Blitz
//
//  Created by Tlaitirang Rathete on 29/4/2025.
//

import SwiftUI

struct SettingsView: View {

    @ObservedObject var highScoreViewModel = HighScoreViewModel()
    @State var countDownInput : String = ""
    @State private var countdownValue: Double = 60
    @State private var NumberOfBubbles: Double = 15
    @State private var playerName: String = ""
    
    var body: some View {
        ZStack {
           
            VStack{
                Label("Game Settings View", systemImage: "")
                    .foregroundStyle(.green)
                    .font(.title)
                    .fontWeight(.black)
                Spacer()
                
                Text("Name")
                    .foregroundColor(.green)
                    .font(.title)
                    .fontWeight(.black)
                TextField("Enter Name", text: $playerName)
                    
                .padding()
                Spacer()
                
           
                Text("Game Time")
                    .foregroundColor(.green)
                    .font(.title)
                    .fontWeight(.black)
                    .padding()
                Text(" \(Int (countdownValue) )")
                    .font(.title)
                Slider(value: $countdownValue, in: 0...60, step: 1 )
                    .padding()
                    .frame(width: 360, height: 60)
                    .onChange(of: countdownValue, perform: {
                        value in
                        countDownInput = "\(Int(value))"
                    })
                
                    .padding()
                
                Text ("Max Number of Bubbles")
                    .foregroundColor(.green)
                    .font(.title)
                    .fontWeight(.black)
                Text("\(Int(NumberOfBubbles))")
                    .font(.title)
                    .padding()
                Slider(value: $NumberOfBubbles, in: 0...15, step: 1 )
                    .frame(width: 320, height: 60)
                        .padding()
                
              
                
                NavigationLink{
                    StartGameView(countDownvalue: countdownValue, NumberOfBubbles: NumberOfBubbles, playerName: playerName)
                }label: {
                    Text("Start Game")
                        .font(.title)
                        .foregroundColor(.green)
                        .padding()
                        .background(.regularMaterial) // Added background color to the button
                        .cornerRadius(10)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
