//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import SwiftUI

struct GameOverView: View {
    var body: some View {
        VStack {
            ScoreView()
            ViewThatFits {
                HStack {
                    BackToHomeButton()
                    RestartGameButton()
                }
                VStack {
                    BackToHomeButton()
                    RestartGameButton()
                }
            }
        }
    }
}

struct OngoingGameScoreView: View {
    @EnvironmentObject var scoreManager: GameScoreManager
    
    var body: some View {
        HStack {
            ComboLabelView(title: "Combo Bonus", value: "\(scoreManager.comboBonus)")
            Spacer()
            ScoreView()
            Spacer()
            ComboLabelView(title: "Combo Multiplier", value: "\(scoreManager.comboMultiplier)x")
        }
        .padding(.horizontal)
    }
}

struct ComboLabelView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
            Text(value)
                .font(.body)
        }
    }
}

struct ScoreView: View {
    @EnvironmentObject var scoreManager: GameScoreManager
    @Environment(\.namespace) var animation
    
    var body: some View {
        VStack {
            Text("SCORE")
                .font(.caption)
                .foregroundColor(.secondary)
            Text("\(scoreManager.score)")
                .font(.largeTitle)
        }
        .matchedGeometryEffect(id: "ScoreView", in: animation ?? Namespace().wrappedValue)
    }
}

struct RestartGameButton: View {
    @Environment(\.namespace) var animation
    @EnvironmentObject var gameStateManager: GameStateManager
    @EnvironmentObject var gameScoreManager: GameScoreManager
    @State var isCompact: Bool
    
    init(isCompact: Bool = false) {
        self._isCompact = State(initialValue: isCompact)
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                gameStateManager.restartGame()
                gameScoreManager.startGame()
            }
        }, label: {
            if isCompact {
                Label("", systemImage: "arrow.clockwise")
                    .tint(.secondary)
            } else {
                Label("Restart Game", systemImage: "arrow.clockwise")
            }
        })
        .buttonStyle(isCompact: isCompact)
        .matchedGeometryEffect(id: "RestartGameButton", in: animation ?? Namespace().wrappedValue)
    }
}

struct BackToHomeButton: View {
    @Environment(\.namespace) var animation
    @EnvironmentObject var gameStateManager: GameStateManager
    @State var isCompact: Bool
    
    init(isCompact: Bool = false) {
        self._isCompact = State(initialValue: isCompact)
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                gameStateManager.resetGame()
            }
        }, label: {
            if isCompact {
                Label("", systemImage: "house.fill")
                    .tint(.secondary)
            } else {
                Label("Back to Home", systemImage: "house.fill")
            }
        })
        .buttonStyle(isCompact: isCompact)
        .matchedGeometryEffect(id: "BackToHomeButton", in: animation ?? Namespace().wrappedValue)
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView()
    }
}

private extension Button {
    @ViewBuilder
    func buttonStyle(isCompact: Bool) -> some View {
        if isCompact {
            buttonStyle(.borderless)
        } else {
            buttonStyle(.bordered)
        }
    }
}
