//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import Foundation

let notStartedStateManager = GameStateManager()

var firstQuestionStateManager: GameStateManager = {
    let stateManager = GameStateManager()
    stateManager.startGame(vidioTrivia)
    stateManager.gameState = .ongoing(quiz: vidioOne, quizNumber: 1, quizCount: 3)
    return stateManager
}()

var answeredStateManager: GameStateManager = {
    let stateManager = GameStateManager()
    stateManager.startGame(vidioTrivia)
    stateManager.gameState = .ongoing(quiz: vidioOne, quizNumber: 2, quizCount: 3)
    return stateManager
}()

var gameOverStateManager: GameStateManager = {
    let stateManager = GameStateManager()
    stateManager.startGame(vidioTrivia)
    stateManager.gameState = .gameOver
    return stateManager
}()
