//
//  Copyright © 2023 Embrace Mobile, Inc. All rights reserved.
//

import Foundation
import EmbraceCommon
import EmbraceOTel
import EmbraceStorage
import EmbraceUpload

extension Embrace {
    static func createStorage(options: Embrace.Options) -> EmbraceStorage? {
        if let storageUrl = EmbraceFileSystem.storageDirectoryURL(
            appId: options.appId,
            appGroupId: options.appGroupId
        ) {
            do {
                let storageOptions = EmbraceStorage.Options(baseUrl: storageUrl, fileName: "db.sqlite")
                return try EmbraceStorage(options: storageOptions)
            } catch {
                ConsoleLog.error("Error initializing Embrace Storage: " + error.localizedDescription)
            }
        } else {
            ConsoleLog.error("Error initializing Embrace Storage!")
        }

        // TODO: Discuss what to do if the storage fails to initialize!
        return nil
    }

    static func createUpload(options: Embrace.Options, deviceId: String) -> EmbraceUpload? {
        // endpoints
        guard let sessionsURL = URL.sessionsEndpoint(basePath: options.endpoints.baseURL),
              let blobsURL = URL.blobsEndpoint(basePath: options.endpoints.baseURL) else {
            ConsoleLog.error("Failed to initialize endpoints!")
            return nil
        }

        let endpoints = EmbraceUpload.EndpointOptions(sessionsURL: sessionsURL, blobsURL: blobsURL)

        // cache
        guard let cacheUrl = EmbraceFileSystem.uploadsDirectoryPath(
            appId: options.appId,
            appGroupId: options.appGroupId
        ),
              let cache = EmbraceUpload.CacheOptions(cacheBaseUrl: cacheUrl)
        else {
            ConsoleLog.error("Failed to initialize upload cache!")
            return nil
        }

        // metadata
        let metadata = EmbraceUpload.MetadataOptions(
            apiKey: options.appId,
            userAgent: EmbraceMeta.userAgent,
            deviceId: deviceId
        )

        do {
            let options = EmbraceUpload.Options(endpoints: endpoints, cache: cache, metadata: metadata)
            let queue = DispatchQueue(label: "com.embrace.upload", attributes: .concurrent)

            return try EmbraceUpload(options: options, queue: queue)
        } catch {
            ConsoleLog.error("Error initializing Embrace Upload: " + error.localizedDescription)
        }

        return nil
    }

    func initializeSessionHandlers() {
        // on new session handler
        sessionLifecycle.onNewSession = { [weak self] sessionId in
            self?.collection.crashReporter?.currentSessionId = sessionId
        }

        // on session ended handler
        sessionLifecycle.onSessionEnded = { [weak self] _ in
            self?.collection.crashReporter?.currentSessionId = nil
        }
    }
}
