//
//  PlayerScore.swift
//  Bubble Blitz
//
//  Created by Tlaitirang Rathete on 29/4/2025.
//

import Foundation

// add HighScore List
struct PlayerScore: Identifiable, Codable {
    var id = UUID()
    let playerName: String
    var score: Int
}
