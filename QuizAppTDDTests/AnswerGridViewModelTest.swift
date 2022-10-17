//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import XCTest

@testable import QuizAppTDD

final class AnswerGridViewModelTest: XCTestCase {
    
    func test_init_withEmptyAnswers() {
        XCTAssertTrue(createEmptyViewModel().answerGrids.isEmpty)
    }
    
    func test_init_withMultipleAnswers_shouldMapToGrid_withProvidedBaseColors() {
        let sut = createViewModel(
            getAnswers: {[
                "answer-one",
                "answer-two"
            ]}, getBaseColors: {[
                .pink,
                .brown
            ]})
        
        XCTAssertEqual(
            sut.answerGrids,
            [
                .init(answer: "answer-one", baseColor: .pink),
                .init(answer: "answer-two", baseColor: .brown)
            ]
        )
    }
    
    func test_selectAnswer_whenSelectedAnswersIsCorrect() {
        let selectedGrid = AnswerGrid(answer: "answer-one", baseColor: .pink)
        
        let sut = createViewModel(
            getAnswers: {[
                "answer-one",
                "answer-two",
                "answer-three"
            ]}, getCorrectAnswer: {
                "answer-one"
            }, getBaseColors: {[
                .pink,
                .brown
            ]})
        
        var completionCalledWithCorrectAnswer: Bool?
        sut.selectAnswer(in: selectedGrid, completion: {
            completionCalledWithCorrectAnswer = $0
        })
        
        XCTAssertEqual(
            sut.answerGrids,
            [
                .init(answer: "answer-one", baseColor: .green, isSelected: true),
                .init(answer: "answer-two", baseColor: .secondary),
                .init(answer: "answer-three", baseColor: .secondary)
            ]
        )
        
        XCTAssertEqual(completionCalledWithCorrectAnswer, true)
    }
    
    func test_selectAnswer_whenSelectedAnswersIsIncorrect() {
        let selectedGrid = AnswerGrid(answer: "answer-two", baseColor: .brown)
        
        let sut = createViewModel(
            getAnswers: {[
                "answer-one",
                "answer-two",
                "answer-three"
            ]}, getCorrectAnswer: {
                "answer-one"
            }, getBaseColors: {[
                .pink,
                .brown
            ]})
        
        var completionCalledWithCorrectAnswer: Bool?
        sut.selectAnswer(in: selectedGrid, completion: {
            completionCalledWithCorrectAnswer = $0
        })
        
        XCTAssertEqual(
            sut.answerGrids,
            [
                .init(answer: "answer-one", baseColor: .green),
                .init(answer: "answer-two", baseColor: .red, isSelected: true),
                .init(answer: "answer-three", baseColor: .secondary)
            ]
        )
        XCTAssertEqual(completionCalledWithCorrectAnswer, false)
    }
    
    func test_resetAnswers_afterSelectAnswer() {
        let sut = createViewModel(
            getAnswers: {[
                "answer-one",
                "answer-two",
                "answer-three"
            ]}, getCorrectAnswer: {
                "answer-one"
            }, getBaseColors: {[
                .pink,
                .brown
            ]})
        
        sut.selectAnswer(
            in: AnswerGrid(answer: "answer-one", baseColor: .pink),
            completion: { _ in }
        )
        
        sut.resetAnswers()
        
        XCTAssertEqual(
            sut.answerGrids,
            [
                .init(answer: "answer-one", baseColor: .pink),
                .init(answer: "answer-two", baseColor: .brown),
                .init(answer: "answer-three", baseColor: .pink)
            ]
        )
    }
    
    private func createViewModel(
        getAnswers: @escaping AnswerOptionsViewModel.AnswersProvider = { [] },
        getCorrectAnswer: @escaping AnswerOptionsViewModel.CorrectAnswerProvider = { "" },
        getBaseColors: @escaping AnswerOptionsViewModel.BaseColorsProvider = { [.pink] }
    ) -> AnswerOptionsViewModel {
        AnswerOptionsViewModel(
            getAnswers: getAnswers,
            getCorrectAnswer: getCorrectAnswer,
            getBaseColors: getBaseColors
        )
    }
    
    private func createEmptyViewModel() -> AnswerOptionsViewModel {
        createViewModel(getAnswers: {[]})
    }

}
