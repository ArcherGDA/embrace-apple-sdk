//
//  Copyright © 2023 Embrace Mobile, Inc. All rights reserved.
//

import Foundation
@testable import EmbraceIO
@testable import EmbraceCommon

class MockURLSessionTaskHandler: URLSessionTaskHandler {
    var didInvokeCreate = false
    var createReceivedTask: URLSessionTask?
    func create(task: URLSessionTask) {
        didInvokeCreate = true
        createReceivedTask = task
    }

    var didInvokeFinish = false
    var finishReceivedParameters: (URLSessionTask, Data?, Error?)?
    func finish(task: URLSessionTask, data: Data?, error: (Error)?) {
        didInvokeFinish = true
        finishReceivedParameters = (task, data, error)
    }

    var didInvokeChangedState = false
    var changedStateReceivedParameter: CaptureServiceState!
    func changedState(to captureServiceState: EmbraceCommon.CaptureServiceState) {
        didInvokeChangedState = true
        changedStateReceivedParameter = captureServiceState
    }
}
