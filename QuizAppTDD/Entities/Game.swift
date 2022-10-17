//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import Foundation

struct Game: Equatable {
    let title: String
    let quizzes: [Quiz]
    let systemImage: String
    let isProminent: Bool
    
    init(
        title: String,
        quizzes: [Quiz],
        systemImage: String = "gamecontroller.fill",
        isProminent: Bool = false
    ) {
        self.title = title
        self.quizzes = quizzes
        self.systemImage = systemImage
        self.isProminent = isProminent
    }
}
