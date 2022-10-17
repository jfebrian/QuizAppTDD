//  Created by Joanda Febrian for Apple Developer Academy - SIG Event.
//  Copyright © 2022 PT Vidio Dot Com. All rights reserved.

import SwiftUI

struct LogoView: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 24) {
                Image("vidio")
                    .resizable()
                    .scaledToFit()
                Rectangle()
                    .foregroundColor(.secondary)
                    .frame(maxWidth: 2, maxHeight: .infinity)
                Image("appleDeveloperAcademy")
                    .resizable()
                    .scaledToFit()
            }
            .frame(maxHeight: 80)
            Text("Student Interest Group Event @ Oct 26")
                .foregroundColor(.secondary)
                .font(.caption)
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
        StartGameView()
    }
}
