//
//  Copyright © 2023 Embrace Mobile, Inc. All rights reserved.
//

import Foundation

@testable import EmbraceOTel

class SpyEmbraceResourceProvider: EmbraceResourceProvider {
    var stubbedGetResources: [EmbraceResource] = []
    func getResources() -> [EmbraceResource] {
        stubbedGetResources
    }
}
