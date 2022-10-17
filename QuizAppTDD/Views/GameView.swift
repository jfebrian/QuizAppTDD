//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import SwiftUI

struct GameView: View {
    @Namespace var animation
    @StateObject var gameStateManager = GameStateManager()
    
    var body: some View {
        VStack {
            GameProgressView()
            QuizView()
                .frame(maxHeight: .infinity)
        }
        .environmentObject(gameStateManager)
        .namespace(animation)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
