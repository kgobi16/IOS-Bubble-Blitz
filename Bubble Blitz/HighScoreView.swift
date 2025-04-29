//
//  HighScoreView.swift
//  Bubble Blitz
//
//  Created by Tlaitirang Rathete on 29/4/2025.
//

import SwiftUI
    
struct HighScoreView: View {
    @State private var playerScores: [PlayerScore] = []
    //Adds Highscore List
    var playerName: String
    var score: Int
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            
            VStack{
                Label("High Score", systemImage: "star.fill")
                    .font(.title)
                
                
                List(playerScores.sorted(by: {$0.score > $1.score}).prefix(5)){ PlayerScore in Text("\(PlayerScore.playerName): \(PlayerScore.score)")}
                // Add HighScore List
            }
        }
        .onAppear{
            loadPlayerScores()
            savePlayerScore()
            //Add HighScore List
        }
    }
    
    private func loadPlayerScores() {
        if let data = UserDefaults.standard.data(forKey: "playerScores") {
            let decoder = JSONDecoder()
            if let decodePlayerScores = try? decoder.decode([PlayerScore].self, from: data) {
                playerScores = decodePlayerScores
            }
        }
                     
    }
    
    private func savePlayerScore() {
        let newPlayerScore = PlayerScore(playerName: playerName, score: score)
        playerScores.append(newPlayerScore)
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(playerScores) {
            UserDefaults.standard.set(encodedData, forKey: "playerScores")
        }
    }
    
    
}

#Preview {
    HighScoreView(playerName: "TestKgobi", score: 5)
}
