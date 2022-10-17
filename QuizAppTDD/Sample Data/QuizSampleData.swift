//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import Foundation

// MARK: - Vidio Trivia

let vidioOne = Quiz(
    question: "What is NOT available in Vidio?",
    correctAnswer: "Ultimate Fighting Championship (UFC)",
    answers: [
        "English Premier League (EPL)",
        "FIFA World Cup Qatar 2022",
        "Ultimate Fighting Championship (UFC)",
        "Formula One (F1)"
    ]
)

let vidioTwo = Quiz(
    question: "What do you call Premium Series that is made by and only available in Vidio?",
    correctAnswer: "Vidio Originals",
    answers: [
        "Vidio Videos",
        "Vidio Premier",
        "Series Vidio",
        "Vidio Originals",
    ]
)

let vidioThree = Quiz(
    question: "Which one is NOT a Vidio Originals Series?",
    correctAnswer: "Doctors",
    answers: [
        "Drama Ratu Drama",
        "Bestie",
        "Serigala Terakhir 2",
        "Doctors"
    ]
)

let vidioTrivia = Game(
    title: "Vidio Trivia",
    quizzes: [
        vidioOne,
        vidioTwo,
        vidioThree
    ],
    systemImage: "video.fill",
    isProminent: true
)

// MARK: - Apple Trivia

let appleOne = Quiz(
    question: "Who is the current CEO of Apple?",
    correctAnswer: "Tim Cook",
    answers: [
        "Steve Jobs",
        "Tim Cook",
        "Craig Federighi",
        "Steve Wozniak",
    ]
)

let appleTwo = Quiz(
    question: "How many years has Apple Inc been running?",
    correctAnswer: "46 years",
    answers: [
        "70 years",
        "24 years",
        "108 years",
        "46 years",
    ]
)

let appleThree = Quiz(
    question: "What is the most best-selling Apple Product by quantity?",
    correctAnswer: "iPhone",
    answers: [
        "AirPods",
        "iPhone",
        "Mac",
        "Apple Watch",
    ]
)

let appleTrivia = Game(
    title: "Apple Trivia",
    quizzes: [
        appleOne,
        appleTwo,
        appleThree
    ],
    systemImage: "applelogo",
    isProminent: false
)

// MARK: - Engineering Trivia

let engineeringOne = Quiz(
    question: "What does TDD stands for?",
    correctAnswer: "Test-Driven Development",
    answers: [
        "Test-Driven Development",
        "Test Due Diligence",
        "Taxi Driver Dance",
        "Time-Driven Development"
    ]
)

let engineeringTwo = Quiz(
    question: "Should you test your code?",
    correctAnswer: "Yes",
    answers: [
        "Yes",
        "Maybe",
        "Not sure",
        "No",
    ]
)

let engineeringThree = Quiz(
    question: "What does Apple annual developer conference called?",
    correctAnswer: "World Wide Developer Conference",
    answers: [
        "Apple Developer Conference",
        "Apple Geniuses Conference",
        "World Wide Developer Conference",
        "iConference",
    ]
)

let engineeringTrivia = Game(
    title: "Engineering",
    quizzes: [
        engineeringOne,
        engineeringTwo,
        engineeringThree
    ],
    systemImage: "laptopcomputer.and.iphone",
    isProminent: false
)

// MARK: - Sample Games

let sampleGames = [
    vidioTrivia,
    appleTrivia,
    engineeringTrivia
]
