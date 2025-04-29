// GameLogic.swift

import SwiftUI

class GameLogic {
    var screenWidth: CGFloat
    var screenHeight: CGFloat
    var bubbleSize: CGFloat = 50
    var existingBubblePositions: [CGRect] = []
    
    init(screenWidth: CGFloat, screenHeight: CGFloat) {
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
    }
    
    func randomPosition() -> CGPoint {
        var newPosition: CGPoint
        var isOverlapping: Bool
        
        let maxAttempts = 100
        
        for _ in 0..<maxAttempts {
            let x = CGFloat.random(in: (0 + bubbleSize / 2)...(screenWidth - bubbleSize / 2)) // Keep bubble within bounds
            let y = CGFloat.random(in: (100 + bubbleSize / 2)...(screenHeight - bubbleSize / 2)) // Adjusted y
            
            newPosition = CGPoint(x: x, y: y)
            
            let newFrame = CGRect(x: x - bubbleSize / 2, y: y - bubbleSize / 2, width: bubbleSize, height: bubbleSize)
            isOverlapping = false
            
            for existingFrame in existingBubblePositions {
                if newFrame.intersects(existingFrame) {
                    isOverlapping = true
                    break
                }
            }
            
            if !isOverlapping {
                return newPosition
            }
        }
        
        // Fallback to a default position if no non-overlapping position is found (should rarely happen)
        return CGPoint(x: screenWidth / 2, y: screenHeight / 2)
    }
    
    func addBubblePosition(_ position: CGPoint) {
        let frame = CGRect(x: position.x - bubbleSize / 2, y: position.y - bubbleSize / 2, width: bubbleSize, height: bubbleSize)
        existingBubblePositions.append(frame)
    }
    
    func removeBubblePosition(_ bubble: Bubble) {
        if let index = existingBubblePositions.firstIndex(where: { $0.midX == bubble.position.x && $0.midY == bubble.position.y }) {
            existingBubblePositions.remove(at: index)
        }
    }
    
    func clearBubblePositions() {
        existingBubblePositions.removeAll()
    }
}
