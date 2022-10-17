//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import XCTest

@testable import QuizAppTDD

final class GameScoreManagerTest: XCTestCase {

    ///    Given: Player is not playing a game
    ///    When: Player starts a game
    ///    Then: Player initial score, combo bonus, and combo multiplier set to 0

    ///    Given: Player is playing a game
    ///    When: Player selects a correct answer
    ///    Then: Player score increases by 10
    
    ///    Given: Player is playing a game
    ///    When: Player selects correct answer
    ///    Then: Player combo bonus increases by 5 times combo multiplier
    
    ///    Given: Player selected a correct answer
    ///    When: Player combo bonus already increase
    ///    Then: Player combo multiplier increases by 1

    ///    Given: Player is playing a game
    ///    When: Player selects a wrong answer
    ///    Then: Player score decreases by 5

    ///    Given: Player selected correct answer
    ///    When: Player selects a wrong answer
    ///    Then: Player score increases by combo bonus

    ///    Given: Player selected correct answer
    ///    When: Player selects a wrong answer
    ///    Then: Player combo bonus and multiplier resets to 0

    ///    Given: Player is playing a game
    ///    When: Player ends the game
    ///    Then: Player score added by the current combo bonus

}
