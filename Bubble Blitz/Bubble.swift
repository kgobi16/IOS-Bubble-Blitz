//
//  Bubble.swift
//  Bubble Blitz
//
//  Created by Tlaitirang Rathete on 29/4/2025.
//

import Foundation
import SwiftUI

struct Bubble: Identifiable {
    let id = UUID()
    let color: Color
    let points: Int
    var position: CGPoint
}

struct BubbleColor {
    let color: Color
    let points: Int
    let probability: Double
}
