//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import SwiftUI

struct QuizView: View {
    @EnvironmentObject var gameStateManager: GameStateManager
    
    var body: some View {
        switch gameStateManager.gameState {
        case .notStarted:
            StartGameView()
        case .ongoing(let quiz, _, _):
            QuizCardView(quiz: quiz)
        case .gameOver:
            GameOverView()
        }
    }
}

struct QuestionLabel: View {
    var question: String

    var body: some View {
        Text(question)
            .font(.title)
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.2)
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
            .environmentObject(stateManager())
    }
    
    static func stateManager() -> GameStateManager {
        let stateManager = GameStateManager()
        stateManager.startGame(vidioTrivia)
        return stateManager
    }
}
