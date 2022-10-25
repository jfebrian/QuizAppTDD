//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import Foundation

final class GameScoreManager: ObservableObject {
    @Published var score = 0
    @Published var comboBonus = 0
    @Published var comboMultiplier = 0
    
    func startGame() {
        score = 0
        comboBonus = 0
        comboMultiplier = 0
    }
    
    func selectCorrectAnswer() {
        score += 10
        comboBonus += 5 * comboMultiplier
        comboMultiplier += 1
    }
    
    func selectWrongAnswer() {
        score -= 5
        score += comboBonus
        comboBonus = 0
        comboMultiplier = 0
    }
    
    func endGame() {
        score += comboBonus
    }
}
