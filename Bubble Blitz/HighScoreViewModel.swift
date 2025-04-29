//
//  HighScoreViewModel.swift
//  Bubble Blitz
//
//  Created by Tlaitirang Rathete on 29/4/2025.
//

import Foundation

class HighScoreViewModel: ObservableObject {
    @Published var taskDescription: String = ""
    @Published var highScores: [PlayerScore] = [] // Array to store high scores
    
    func resetHighScores() {
        highScores.removeAll() // Function to clear high scores
    }
    
    func loadHighScores() {
        if let data = UserDefaults.standard.data(forKey: "highScores") {
            let decoder = JSONDecoder()
            if let decodedScores = try? decoder.decode([PlayerScore].self, from: data) {
                highScores = decodedScores
            }
        }
    }
    
    func saveHighScores() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(highScores) {
            UserDefaults.standard.set(encodedData, forKey: "highScores")
        }
    }
    
    func addScore(playerName: String, score: Int) {
        let newScore = PlayerScore(playerName: playerName, score: score)
        highScores.append(newScore)
        saveHighScores()
    }
}
