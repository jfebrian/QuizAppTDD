//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import SwiftUI

final class AnswerOptionsViewModel: ObservableObject {
    
    @Published var answerGrids: [AnswerGrid]

    typealias AnswersProvider = () -> [String]
    typealias CorrectAnswerProvider = () -> String
    typealias BaseColorsProvider = () -> [Color]

    private let getAnswers: AnswersProvider
    private let getCorrectAnswer: CorrectAnswerProvider
    private let getBaseColors: BaseColorsProvider

    private var hasSelectedAnswer: Bool = false

    init(
        getAnswers: @escaping AnswersProvider,
        getCorrectAnswer: @escaping CorrectAnswerProvider,
        getBaseColors: @escaping BaseColorsProvider = defaultBaseColors
    ) {
        self.getAnswers = getAnswers
        self.getCorrectAnswer = getCorrectAnswer
        self.getBaseColors = getBaseColors

        let baseColors = getBaseColors()
        _answerGrids = .init(
            initialValue: getAnswers().enumerated().map {
                .init(
                    answer: $0.element,
                    baseColor: baseColors[$0.offset % baseColors.count]
                )
            }
        )
    }

    func resetAnswers() {
        hasSelectedAnswer = false
        resetAnswerGrids()
    }

    private func resetAnswerGrids() {
        let baseColors = getBaseColors()
        answerGrids = getAnswers().enumerated().map {
            .init(
                answer: $0.element,
                baseColor: baseColors[$0.offset % baseColors.count]
            )
        }
    }

    func selectAnswer(
        in selectedGrid: AnswerGrid,
        completion: @escaping (_ isCorrectAnswer: Bool) -> Void
    ) {
        guard !hasSelectedAnswer else { return }

        let correctAnswer = getCorrectAnswer()
        hasSelectedAnswer = true
        answerGrids = answerGrids.map { grid in
            let isCorrectAnswer = grid.answer == correctAnswer
            if grid == selectedGrid {
                return AnswerGrid(
                    answer: grid.answer,
                    baseColor: isCorrectAnswer ? .green : .red,
                    isSelected: true
                )
            } else {
                return AnswerGrid(
                    answer: grid.answer,
                    baseColor: isCorrectAnswer ? .green : .secondary,
                    isSelected: false
                )
            }
        }

        completion(selectedGrid.answer == correctAnswer)
    }
}

struct AnswerGrid: Equatable {
    let answer: String
    let isSelected: Bool
    private let baseColor: Color

    var color: Color {
        return isSelected ? baseColor : baseColor.opacity(0.2)
    }

    init(answer: String, baseColor: Color, isSelected: Bool = false) {
        self.answer = answer
        self.baseColor = baseColor
        self.isSelected = isSelected
    }
}

private func defaultBaseColors() -> [Color] {
    [
        .indigo,
        .blue,
        .yellow,
        .pink
    ]
}
