//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import XCTest

@testable import QuizAppTDD

final class GameStateManagerTest: XCTestCase {
    func test_init() {
        let sut = GameStateManager()
        
        XCTAssertEqual(sut.gameState, .notStarted)
        XCTAssertNil(sut.currentQuiz)
        XCTAssertEqual(sut.progressLabel, "Vidio Games")
        XCTAssertEqual(sut.progress, 0)
    }
    
    func test_startGame_withEmptyQuizGame() {
        let sut = GameStateManager()
        let emptyQuizGame = Game(title: "any", quizzes: [])
        
        sut.startGame(emptyQuizGame)
        
        XCTAssertEqual(sut.gameState, .gameOver)
        XCTAssertNil(sut.currentQuiz)
        XCTAssertEqual(sut.progressLabel, "Game Over")
        XCTAssertEqual(sut.progress, 1)
    }
    
    func test_startGame_withOneQuizGame() {
        let quizStub = Quiz(question: "anything", correctAnswer: "any", answers: ["any"])
        let oneQuizGame = Game(title: "any", quizzes: [quizStub])
        let sut = GameStateManager()
        
        sut.startGame(oneQuizGame)
        
        XCTAssertEqual(sut.gameState, .ongoing(quiz: quizStub, quizNumber: 1, quizCount: 1))
        XCTAssertEqual(sut.currentQuiz, quizStub)
        XCTAssertEqual(sut.progressLabel, "Quiz 1 of 1")
        XCTAssertEqual(sut.progress, 0)
    }
    
    func test_startGame_whenProvidedMultipleQuiz_shouldUpdateQuizzes_withMultipleQuiz() {
        let firstQuiz = Quiz(question: "anything", correctAnswer: "any", answers: ["any"])
        let multipleQuizGame = Game(title: "any", quizzes: [firstQuiz, .sample()])
        let sut = GameStateManager()
        
        sut.startGame(multipleQuizGame)
        
        XCTAssertEqual(sut.gameState, .ongoing(quiz: firstQuiz, quizNumber: 1, quizCount: 2))
        XCTAssertEqual(sut.currentQuiz, firstQuiz)
        XCTAssertEqual(sut.progressLabel, "Quiz 1 of 2")
        XCTAssertEqual(sut.progress, 0)
    }
    
    func test_resetGame() {
        let sut = GameStateManager()
        sut.startGame(.sample())
        
        sut.resetGame()
        
        XCTAssertEqual(sut.gameState, .notStarted)
        XCTAssertNil(sut.currentQuiz)
        XCTAssertEqual(sut.progressLabel, "Vidio Games")
        XCTAssertEqual(sut.progress, 0)
    }
    
    func test_restartGame() {
        let firstQuiz = Quiz(question: "anything", correctAnswer: "any", answers: ["any"])
        let multipleQuizGame = Game(title: "any", quizzes: [firstQuiz, .sample()])
        let sut = GameStateManager()
        sut.startGame(multipleQuizGame)
        sut.nextQuiz()
        
        sut.restartGame()
        
        XCTAssertEqual(sut.gameState, .ongoing(quiz: firstQuiz, quizNumber: 1, quizCount: 2))
        XCTAssertEqual(sut.currentQuiz, firstQuiz)
        XCTAssertEqual(sut.progressLabel, "Quiz 1 of 2")
        XCTAssertEqual(sut.progress, 0)
    }
    
    func test_nextQuiz_shouldGoToNextQuiz() {
        let firstQuiz = Quiz(question: "anything", correctAnswer: "any", answers: ["any"])
        let secondQuiz = Quiz(question: "second", correctAnswer: "any", answers: ["any"])
        let multipleQuizGame = Game(title: "any", quizzes: [firstQuiz, secondQuiz])
        let sut = GameStateManager()
        sut.startGame(multipleQuizGame)
        
        sut.nextQuiz()
        
        XCTAssertEqual(sut.gameState, .ongoing(quiz: secondQuiz, quizNumber: 2, quizCount: 2))
        XCTAssertEqual(sut.currentQuiz, secondQuiz)
        XCTAssertEqual(sut.progressLabel, "Quiz 2 of 2")
        XCTAssertEqual(sut.progress, 0.5)
    }

    func test_nextQuiz_onLastQuiz_shouldEndGame_andCallGameOverAction() {
        let firstQuiz = Quiz(question: "anything", correctAnswer: "any", answers: ["any"])
        let secondQuiz = Quiz(question: "second", correctAnswer: "any", answers: ["any"])
        let multipleQuizGame = Game(title: "any", quizzes: [firstQuiz, secondQuiz])
        let sut = GameStateManager()
        sut.startGame(multipleQuizGame)
        
        var gameOverActionCalled = 0
        sut.nextQuiz() { gameOverActionCalled += 1 }
        XCTAssertEqual(gameOverActionCalled, 0)
        
        sut.nextQuiz() { gameOverActionCalled += 1 }
        XCTAssertEqual(gameOverActionCalled, 1)

        XCTAssertEqual(sut.gameState, .gameOver)
        XCTAssertEqual(sut.currentQuiz, nil)
        XCTAssertEqual(sut.progressLabel, "Game Over")
        XCTAssertEqual(sut.progress, 1)
    }
}

private extension Game {
    static func sample(quizzes: [Quiz] = []) -> Game {
        Game(title: "any-game", quizzes: [])
    }
}

private extension Quiz {
    static func sample() -> Quiz {
        Quiz(question: "any", correctAnswer: "any", answers: [])
    }
}
