//
//  Copyright © 2023 Embrace Mobile, Inc. All rights reserved.
//

import XCTest
import TestSupport
import EmbraceCommon
import EmbraceStorage
import OpenTelemetryApi
import UIKit
@testable import EmbraceOTel
@testable import EmbraceIO

// swiftlint:disable force_cast

class LowMemoryWarningCollectorTests: XCTestCase {

    override func setUpWithError() throws {
        let storageOptions = EmbraceStorage.Options(named: #file)
        let storage = try EmbraceStorage(options: storageOptions)
        EmbraceOTel.setup(spanProcessor: .with(storage: storage))
    }

    func test_started() {
        // given a started collector
        let collector = LowMemoryWarningCollector()
        collector.install(context: .testContext)
        collector.start()

        // when a memory warning notification is received
        NotificationCenter.default.post(Notification(name: UIApplication.didReceiveMemoryWarningNotification))

        // then a span event is recorded
        // TODO: Need session span to test this!
    }

    func test_notStarted() {
        // given a collector that is not started
        let collector = LowMemoryWarningCollector()
        collector.install(context: .testContext)

        // when a memory warning notification is received
        NotificationCenter.default.post(Notification(name: UIApplication.didReceiveMemoryWarningNotification))

        // then a span event is not recorded
        // TODO: Need session span to test this!
    }

    func test_stopped() {
        // given a collector that is started
        let collector = LowMemoryWarningCollector()
        collector.install(context: .testContext)
        collector.start()

        // when the collector is stopped and a new notification is received
        collector.stop()
        NotificationCenter.default.post(Notification(name: UIApplication.didReceiveMemoryWarningNotification))

        // then a span event is not recorded
        // TODO: Need session span to test this!
    }
}

// swiftlint:enable force_cast