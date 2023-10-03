//
//  Copyright © 2023 Embrace Mobile, Inc. All rights reserved.
//

import Foundation

enum SessionState: Int {
    case foreground = 0
    case background

    var rawStringValue: String {
        switch self {
        case .foreground: return "foreground"
        case .background: return "background"
        }
    }
}
