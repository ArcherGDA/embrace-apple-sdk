//
//  Copyright © 2023 Embrace Mobile, Inc. All rights reserved.
//

import Foundation
import EmbraceCommon
import EmbraceStorage

class SessionPayloadBuilder {

    static var resourceName = "session.upload_index"

    class func build(for sessionRecord: SessionRecord, storage: EmbraceStorage) -> SessionPayload {
        var resource: ResourceRecord?

        do {
            // fetch resource
            resource = try storage.fetchResource(key: resourceName)
        } catch {
            ConsoleLog.debug("Error fetching \(resourceName) resource!")
        }

        // increment counter or create resource if needed
        var counter: Int = -1

        do {
            if var resource = resource {
                counter = (Int(resource.value) ?? 0) + 1
                resource.value = String(counter)
                try storage.upsertResource(resource)
            } else {
                resource = try storage.addResource(key: resourceName, value: "1", resourceType: .permanent)
                counter = 1
            }
        } catch {
            ConsoleLog.debug("Error updating \(resourceName) resource!")
        }

        // build payload
        return SessionPayload(from: sessionRecord, resourceFetcher: storage, counter: counter)
    }
}
