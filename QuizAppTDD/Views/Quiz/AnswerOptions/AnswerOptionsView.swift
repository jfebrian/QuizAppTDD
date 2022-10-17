//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import SwiftUI

struct AnswerOptionsView: View {
    @EnvironmentObject var gameStateManager: GameStateManager
    @StateObject var viewModel: AnswerOptionsViewModel

    var body: some View {
        ViewThatFits {
            AnswerStackView(viewModel: viewModel, answerButton: answerButton(for:))
            AnswerGridView(viewModel: viewModel, answerButton: answerButton(for:))
        }.onChange(of: gameStateManager.gameState) { _ in
            viewModel.resetAnswers()
        }
    }
    
    private func answerButton(for grid: AnswerGrid) -> AnswerButton {
        AnswerButton(grid: grid) {
            viewModel.selectAnswer(in: grid) { isCorrectAnswer in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeOut) {
                        gameStateManager.nextQuiz()
                    }
                }
            }
        }
    }
}

struct AnswerGridView: View {
    @ObservedObject var viewModel: AnswerOptionsViewModel

    let answerButton: (AnswerGrid) -> AnswerButton

    var body: some View {
        LazyVGrid(columns: Array(
            repeating: GridItem(.flexible(), spacing: 8),
            count: 2
        )) {
            ForEach(viewModel.answerGrids, id: \.answer) { grid in
                answerButton(grid)
            }
        }
    }
}

struct AnswerStackView: View {
    @ObservedObject var viewModel: AnswerOptionsViewModel
    
    let answerButton: (AnswerGrid) -> AnswerButton
    
    var body: some View {
        LazyVStack {
            ForEach(viewModel.answerGrids, id: \.answer) { grid in
                answerButton(grid)
            }
        }
    }
}

struct AnswerButton: View {
    var grid: AnswerGrid
    var tapAction: () -> Void
    
    var body: some View {
        Button {
            withAnimation(.easeIn(duration: 0.5)) {
                tapAction()
            }
        } label: {
            Text(grid.answer)
                .foregroundColor(grid.isSelected ? .white : .primary)
                .bold(grid.isSelected)
                .multilineTextAlignment(.center)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(in: RoundedRectangle(cornerRadius: 8))
                .backgroundStyle(grid.color)
        }
        .buttonStyle(.plain)
    }
}

struct AnswerOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer(minLength: 240)
            AnswerOptionsView(viewModel: .init(
                getAnswers: { answeredStateManager.currentQuiz?.answers ?? [] },
                getCorrectAnswer: { answeredStateManager.currentQuiz?.correctAnswer ?? "" }
            )).environmentObject(answeredStateManager)
            Spacer()
        }
    }
}
