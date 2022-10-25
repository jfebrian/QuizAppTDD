//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import SwiftUI

struct GameView: View {
    @Namespace var animation
    @StateObject var gameStateManager = GameStateManager()
    @StateObject var gameScoreManager = GameScoreManager()
    
    var body: some View {
        VStack {
            GameProgressView()
            QuizView()
                .frame(maxHeight: .infinity)
        }
        .environmentObject(gameStateManager)
        .environmentObject(gameScoreManager)
        .namespace(animation)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
