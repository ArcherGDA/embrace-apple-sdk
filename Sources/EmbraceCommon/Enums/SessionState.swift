//
//  Copyright © 2023 Embrace Mobile, Inc. All rights reserved.
//

import Foundation

public enum SessionState: String {
    case foreground, background
}

#if canImport(UIKit)
import UIKit

public extension SessionState {
    init?(appState: UIApplication.State) {
        if appState == .background {
            self.init(rawValue: "background")
        } else {
            self.init(rawValue: "foreground")
        }
    }
}
#endif
