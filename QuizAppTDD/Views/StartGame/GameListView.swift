//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import SwiftUI

struct GameListView: View {
    @State var games: [Game] = sampleGames
    
    var body: some View {
        ViewThatFits {
            LazyVStack(spacing: 16) {
                ForEach(games, id: \.title) { game in
                    StartGameButton(game: game)
                        .frame(maxWidth: .infinity)
                }
            }

            HStack(spacing: 16) {
                ForEach(games, id: \.title) { game in
                    StartGameButton(game: game)
                }
            }
        }
        .padding()
        .dynamicTypeSize(.xSmall ... .accessibility2)
    }
}

struct StartGameButton: View {
    @EnvironmentObject var gameStateManager: GameStateManager
    
    let game: Game
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.easeInOut) {
                    gameStateManager.startGame(game)
                }
            }, label: {
                Label(game.title, systemImage: game.systemImage)
                    .font(.title)
                    .frame(maxWidth: .infinity)
            })
            .buttonStyle(isProminent: game.isProminent)
        }
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView()
        StartGameView()
    }
}

private extension Button {
    @ViewBuilder
    func buttonStyle(isProminent: Bool) -> some View {
        if isProminent {
            buttonStyle(.borderedProminent)
        } else {
            buttonStyle(.bordered)
        }
    }
}
