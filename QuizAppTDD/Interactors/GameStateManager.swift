//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import Foundation

enum GameState: Equatable {
    case notStarted
    case ongoing(quiz: Quiz, quizNumber: Int, quizCount: Int)
    case gameOver
}

final class GameStateManager: ObservableObject {
    @Published var gameState: GameState = .notStarted
    
    var progress: Double {
        switch gameState {
        case .notStarted:
            return 0
        case .ongoing(_, let quizNumber, let quizCount):
            return Double(quizNumber-1) / Double(quizCount)
        case .gameOver:
            return 1
        }
    }
    
    var progressLabel: String {
        switch gameState {
        case .notStarted:
            return "Vidio Games"
        case .ongoing(_, let quizNumber, let quizCount):
            return "Quiz \(quizNumber) of \(quizCount)"
        case .gameOver:
            return "Game Over"
        }
    }
    
    var currentQuiz: Quiz? {
        guard let currentQuizNumber else { return nil }
        
        return quizzes[currentQuizNumber-1]
    }
    
    private var quizzes: [Quiz] = []
    
    private var currentQuizNumber: Int? {
        if case let .ongoing(_, quizNumber, _) = gameState {
            return quizNumber
        }
        
        return nil
    }
    
    private var quizCount: Int {
        quizzes.count
    }
    
    private var quizHasEnded: Bool {
        return gameState == .gameOver
    }
    
    private var isOnLastQuiz: Bool {
        currentQuizNumber == quizCount
    }
    
    func resetGame() {
        quizzes = []
        gameState = .notStarted
    }
    
    func restartGame() {
        gameState = quizzes.isEmpty ? .gameOver : .ongoing(
            quiz: quizzes[0],
            quizNumber: 1,
            quizCount: quizCount
        )
    }
    
    func startGame(_ game: Game) {
        quizzes = game.quizzes
        gameState = quizzes.isEmpty ? .gameOver : .ongoing(
            quiz: quizzes[0],
            quizNumber: 1,
            quizCount: quizCount
        )
    }
    
    func nextQuiz(gameOverAction: () -> Void = {}) {
        guard !quizHasEnded else { return }

        if isOnLastQuiz {
            endGame()
            gameOverAction()
        } else if let currentQuizNumber {
            gameState = .ongoing(
                quiz: quizzes[currentQuizNumber],
                quizNumber: currentQuizNumber + 1,
                quizCount: quizCount
            )
        }
    }
    
    private func endGame() {
        gameState = .gameOver
    }
}
