//
//  Copyright © 2023 Embrace Mobile, Inc. All rights reserved.
//

import XCTest

@testable import EmbraceOTel

class EmbraceLoggerSharedStateTests: XCTestCase {
    private var sut: EmbraceLoggerSharedState!

    func test_default_hasDefaultEmbraceLoggerConfig() {
        whenInvokingDefaultEmbraceLoggerSharedState()
        thenConfig(is: DefaultEmbraceLoggerConfig())
    }

    func test_default_hasNoProcessors() {
        whenInvokingDefaultEmbraceLoggerSharedState()
        thenProcessorsArrayIsEmpty()
    }

    func test_updateConfig_thenOriginalConfigShouldBeUpdated() {
        class ZeroedConfig: EmbraceLoggerConfig {
            var maxInactivityTime: Int = 0
            var maxTimeBetweenLogs: Int = 0
            var maxMessageLength: Int = 0
            var maxAttributes: Int = 0
            var logAmountLimit: Int = 0
        }
        givenEmbraceLoggerSharedState(config: DefaultEmbraceLoggerConfig())
        whenInvokingUpdate(withConfig: ZeroedConfig())
        thenConfig(is: ZeroedConfig())
    }
}

private extension EmbraceLoggerSharedStateTests {
    func givenEmbraceLoggerSharedState(config: any EmbraceLoggerConfig) {
        sut = .init(resource: .init(), config: config, processors: [])
    }

    func whenInvokingUpdate(withConfig config: any EmbraceLoggerConfig) {
        sut.update(config)
    }

    func whenInvokingDefaultEmbraceLoggerSharedState() {
        sut = .default()
    }

    func thenConfig(is config: any EmbraceLoggerConfig) {
        XCTAssertEqual(sut.config.logAmountLimit, config.logAmountLimit)
    }

    func thenProcessorsArrayIsEmpty() {
        XCTAssertTrue(sut.processors.isEmpty)
    }
}
