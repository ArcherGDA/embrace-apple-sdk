//
//  Copyright © 2023 Embrace Mobile, Inc. All rights reserved.
//

import EmbraceCommon
import EmbraceStorage

class PayloadUtils {
    public static func fetchResources(from fetcher: EmbraceStorageResourceFetcher, sessionId: String?) -> [ResourceRecord] {
        guard let sessionId = sessionId else { return [] }

        do {
            let resources = try fetcher.fetchAllResourceForSession(sessionId: sessionId) ?? []
            return resources
        } catch let e {
            ConsoleLog.error("Failed to fetch resource records from storage: \(e.localizedDescription)")
        }

        return []
    }
}
