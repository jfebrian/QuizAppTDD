//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import XCTest

@testable import QuizAppTDD

final class GameScoreManagerTest: XCTestCase {
    
    let sut = GameScoreManager()
    
    override func setUp() {
        sut.startGame()
    }

    ///    Given: Player is not playing a game
    ///    When: Player starts a game
    ///    Then: Player initial score, combo bonus, and combo multiplier set to 0
    func testStartGame_shouldSetScore_comboBonus_andMultiplierToZero() {
        XCTAssertEqual(sut.score, 0)
        XCTAssertEqual(sut.comboBonus, 0)
        XCTAssertEqual(sut.comboMultiplier, 0)
    }

    ///    Given: Player is playing a game
    ///    When: Player selects a correct answer
    ///    Then: Player score increases by 10
    func testSelectCorrectAnswer_shouldIncreaseScoreByTen() {
        sut.selectCorrectAnswer()
        
        XCTAssertEqual(sut.score, 10)
        
        sut.selectCorrectAnswer()
        
        XCTAssertEqual(sut.score, 20)
    }
    
    ///    Given: Player is playing a game
    ///    When: Player selects correct answer
    ///    Then: Player combo bonus increases by 5 times combo multiplier
    ///    Then: Player combo multiplier increases by 1
    func testSelectCorrectAnswer_shouldIncreaseComboBonus_andComboMultiplier() {
        sut.selectCorrectAnswer()
        XCTAssertEqual(sut.comboBonus, 0)
        XCTAssertEqual(sut.comboMultiplier, 1)
        
        sut.selectCorrectAnswer()
        XCTAssertEqual(sut.comboBonus, 5)
        XCTAssertEqual(sut.comboMultiplier, 2)
        
        sut.selectCorrectAnswer()
        XCTAssertEqual(sut.comboBonus, 15)
        XCTAssertEqual(sut.comboMultiplier, 3)
    }

    ///    Given: Player is playing a game
    ///    When: Player selects a wrong answer
    ///    Then: Player score decreases by 5
    func testSelectWrongAnswer_shouldDecreaseScoreByFive() {
        sut.selectWrongAnswer()
        
        XCTAssertEqual(sut.score, -5)
        
        sut.selectWrongAnswer()
        
        XCTAssertEqual(sut.score, -10)
    }

    ///    Given: Player selected correct answer
    ///    When: Player selects a wrong answer
    ///    Then: Player score increases by combo bonus
    func testSelectWrongAnswer_shouldIncreaseScoreByComboBonus() {
        sut.selectCorrectAnswer()
        sut.selectCorrectAnswer()
        sut.selectCorrectAnswer()
        
        sut.selectWrongAnswer()
        
        XCTAssertEqual(sut.score, 40)
    }

    ///    Given: Player selected correct answer
    ///    When: Player selects a wrong answer
    ///    Then: Player combo bonus and multiplier resets to 0
    func testSelectWrongAnswer_shouldResetComboBonus_andMultiplierToZero() {
        sut.selectCorrectAnswer()
        sut.selectCorrectAnswer()
        sut.selectCorrectAnswer()
        
        sut.selectWrongAnswer()
        XCTAssertEqual(sut.comboBonus, 0)
        XCTAssertEqual(sut.comboMultiplier, 0)
    }

    ///    Given: Player is playing a game
    ///    When: Player ends the game
    ///    Then: Player score added by the current combo bonus
    func testEndGame_shouldIncreaseScore_byCurrentComboBonus() {
        sut.selectCorrectAnswer()
        sut.selectCorrectAnswer()
        sut.selectCorrectAnswer()
        
        sut.endGame()
        
        XCTAssertEqual(sut.score, 45)
        
    }
    
    ///    Given: Player ended a game
    ///    When: Player starts a new game
    ///    Then: Player score, combo bonus, and combo multiplier reset to 0
    func testStartGame_afterPreviousGame_shouldResetToZero() {
        sut.selectCorrectAnswer()
        sut.selectCorrectAnswer()
        sut.selectCorrectAnswer()
        sut.endGame()
        
        sut.startGame()
        
        XCTAssertEqual(sut.score, 0)
        XCTAssertEqual(sut.comboBonus, 0)
        XCTAssertEqual(sut.comboMultiplier, 0)
    }

}
