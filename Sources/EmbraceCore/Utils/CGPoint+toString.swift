//
//  Copyright © 2023 Embrace Mobile, Inc. All rights reserved.
//

import Foundation

extension CGPoint {
    func toString() -> String {
        "\(trunc(x)),\(trunc(y))"
    }
}
