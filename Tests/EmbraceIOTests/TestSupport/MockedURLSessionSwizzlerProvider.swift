//
//  Copyright © 2023 Embrace Mobile, Inc. All rights reserved.
//

@testable import EmbraceIO

class MockedURLSessionSwizzlerProvider: URLSessionSwizzlerProvider {
    let swizzlers: [any URLSessionSwizzler]

    init(swizzlers: [any URLSessionSwizzler]) {
        self.swizzlers = swizzlers
    }

    var didGetAll = false
    func getAll(usingHandler handler: URLSessionTaskHandler) -> [any URLSessionSwizzler] {
        didGetAll = true
        return swizzlers
    }
}
