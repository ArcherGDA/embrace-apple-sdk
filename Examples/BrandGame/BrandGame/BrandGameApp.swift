//
//  Copyright © 2023 Embrace Mobile, Inc. All rights reserved.
//

import SwiftUI

import EmbraceIO

@main
struct BrandGameApp: App {

    @State var settings: AppSettings = AppSettings()

    init() {
        do {
            try Embrace
                .setup(options: embraceOptions)
                .start()

            addGitInfoProperties()
            smokeTestIfNecessary()
        } catch let e {
            print("Error starting Embrace \(e.localizedDescription)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.settings, settings)
        }
    }
}
