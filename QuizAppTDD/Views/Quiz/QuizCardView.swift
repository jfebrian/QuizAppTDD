//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import SwiftUI

struct QuizCardView: View {
    @EnvironmentObject var gameStateManager: GameStateManager
    
    let quiz: Quiz
    
    var body: some View {
        VStack {
            OngoingGameScoreView()
            QuestionLabel(question: quiz.question)
                .frame(maxHeight: .infinity)
            AnswerOptionsView(
                viewModel: .init(
                    getAnswers: { gameStateManager.currentQuiz?.answers ?? [] },
                    getCorrectAnswer: { gameStateManager.currentQuiz?.correctAnswer ?? "" }
                )
            )
        }
        .padding()
        .dynamicTypeSize(.xSmall ... .accessibility1)
    }
}

struct QuizCardView_Previews: PreviewProvider {
    static let gameStateManager: GameStateManager = {
        let stateManager = GameStateManager()
        stateManager.startGame(vidioTrivia)
        stateManager.gameState = .ongoing(quiz: vidioOne, quizNumber: 1, quizCount: 3)
        return stateManager
    }()
    
    static var previews: some View {
        QuizCardView(quiz: vidioOne)
            .environmentObject(gameStateManager)
    }
}
