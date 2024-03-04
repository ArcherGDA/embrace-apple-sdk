//
//  Copyright © 2023 Embrace Mobile, Inc. All rights reserved.
//

import Foundation

extension String {
    static func random() -> String {
        UUID().uuidString
    }
}
