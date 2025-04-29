//
//  StartGameView.swift
//  Bubble Blitz
//
//  Created by Tlaitirang Rathete on 29/4/2025.
//

import SwiftUI
import AVFoundation

struct StartGameView: View {
    @State var countDownvalue: Double
    @State var NumberOfBubbles: Double
    @State private var bubbles: [Bubble] = [] // Use the Bubble struct
    @State private var score: Int = 0
    @State private var timer: Timer?
    @State private var timeRemaining: Int = 0
    @State private var consecutiveColor: String?
    @State private var gameOver: Bool = false
    @State private var audioPlayer: AVAudioPlayer?
    @Environment(\.presentationMode) var presentationMode
    
    let playerName: String
    
    let bubbleColors: [BubbleColor] = [ // Use the BubbleColor struct
        BubbleColor(color: .red, points: 1, probability: 0.4),
        BubbleColor(color: .pink, points: 2, probability: 0.3),
        BubbleColor(color: .green, points: 5, probability: 0.15),
        BubbleColor(color: .blue, points: 8, probability: 0.1),
        BubbleColor(color: .black, points: 10, probability: 0.05)
    ]
    
    let gameLogic: GameLogic
    
    init(countDownvalue: Double, NumberOfBubbles: Double, playerName: String) {
        self.countDownvalue = countDownvalue
        self.NumberOfBubbles = NumberOfBubbles
        self.playerName = playerName
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        self.gameLogic = GameLogic(screenWidth: screenWidth, screenHeight: screenHeight)
    }
    
    var body: some View {
        ZStack {
            Image("Space") // Add the background image
             .resizable()
             .ignoresSafeArea()
             .scaledToFill()
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .fontWeight(.black)
                    .foregroundStyle(.white)
                Text("Score: \(score)")
                    .fontWeight(.black)
                    .foregroundStyle(.white)
                
                ForEach(bubbles) { bubble in
                    Circle()
                        .fill(bubble.color)
                        .frame(width: 50, height: 50)
                        .position(bubble.position)
                        .onTapGesture {
                            popBubble(bubble: bubble)
                        }
                }
                
                
                Spacer()
                
               
                    
                }
            if gameOver {
                HighScoreView(playerName: playerName, score: score)
                Button("Restart Game"){
                    SettingsView()
                }
                  
            }
        }
        .onAppear {
            startGame()
        }
        .onDisappear {
            stopGame()
        }
    }
    
    // --- Game Logic Functions ---
    
    func startGame() {
        timeRemaining = Int(countDownvalue)
        generateBubbles()
        startTimer()
    }
    
    func resetGame() {
        score = 0
        timeRemaining = Int(countDownvalue)
        bubbles.removeAll()
        gameLogic.clearBubblePositions()
        consecutiveColor = nil
        gameOver = false
        startGame()
    }
    
    func stopGame() {
        timer?.invalidate()
        timer = nil
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            timeRemaining -= 1
            if timeRemaining <= 0 {
                endGame()
            }
            refreshBubbles()
        }
    }
    
    func endGame() {
        stopGame()
        gameOver = true
    }
    
    func generateBubbles() {
        bubbles.removeAll()
        gameLogic.clearBubblePositions()
        
        for _ in 0..<Int.random(in: 1...Int(NumberOfBubbles)) {
            let color = getRandomBubbleColor()
            let position = gameLogic.randomPosition()
            let bubble = Bubble(color: color.color, points: color.points, position: position) // Use the Bubble struct
            bubbles.append(bubble)
            gameLogic.addBubblePosition(position)
        }
    }
    
    func getRandomBubbleColor() -> BubbleColor { // Use the BubbleColor struct
        let random = Double.random(in: 0...1)
        var cumulativeProbability = 0.0
        for color in bubbleColors {
            cumulativeProbability += color.probability
            if random < cumulativeProbability {
                return color
            }
        }
        return bubbleColors.first!
    }
    
    func popBubble(bubble: Bubble) {
        if let index = bubbles.firstIndex(where: { $0.id == bubble.id }) {
            bubbles.remove(at: index)
            gameLogic.removeBubblePosition(bubble)
            var points = bubble.points
            if consecutiveColor == bubble.color.description {
                points = Int(Double(points) * 1.5)
            }
            score += points
            consecutiveColor = bubble.color.description
        }
        playSound(sound: "bubblePop", type: "wav")
    }
    
    func refreshBubbles() {
        let numToRemove = Int.random(in: 0...bubbles.count / 2)
        for _ in 0..<numToRemove {
            if !bubbles.isEmpty {
                let index = Int.random(in: 0..<bubbles.count)
                gameLogic.removeBubblePosition(bubbles[index])
                bubbles.remove(at: index)
            }
        }
        generateBubbles()
    }
    
    func playSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("ERROR: Could not find and play the sound file!")
            }
        }
    }
}
#Preview {
  StartGameView(countDownvalue: 4.0, NumberOfBubbles: 10.0, playerName: "Test Player")
 }
