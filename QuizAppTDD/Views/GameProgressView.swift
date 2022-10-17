//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import SwiftUI

struct GameProgressView: View {
    @EnvironmentObject var gameStateManager: GameStateManager
    
    var body: some View {
        VStack {
            ZStack {
                if case .ongoing(_,let quizNumber,_) = gameStateManager.gameState {
                    HStack {
                        BackToHomeButton(isCompact: true)
                        Spacer()
                        if quizNumber > 1 {
                            RestartGameButton(isCompact: true)
                        }
                    }
                }
                Text(gameStateManager.progressLabel)
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            ProgressView(value: gameStateManager.progress)
                .animation(.easeIn, value: gameStateManager.progress)
        }
        .padding()
        .dynamicTypeSize(.xSmall ... .accessibility2)
    }
}

struct GameProgressView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            GameProgressView()
                .environmentObject(notStartedStateManager)
            GameProgressView()
                .environmentObject(firstQuestionStateManager)
            GameProgressView()
                .environmentObject(answeredStateManager)
            GameProgressView()
                .environmentObject(gameOverStateManager)
        }
    }
}
