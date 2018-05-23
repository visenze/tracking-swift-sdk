//
//  UserTracker.swift
//  UserTrackingSDK
//
//  Created by visenze on 22/5/18.
//  Copyright © 2018 ViSenze. All rights reserved.
//

/**
 The traker for tracking user events
 */
class UserTracker {
    
    // MARK: Constants
    private static let DEFAULT_TIMEOUT_INTERVAL = 10.0
    private static let VISENZE_TRACK_URL = "https://track.visenze.com"
    private static let VISENZE_TRACK_ENDPOINT = "__aq.gif"
    private static let HTTP_COOKIE_FIELD = "Cookie"
    private static let USER_AGENT = "tracking-swift-sdk/1.0.0"
    private static let USER_AGENT_HEADER = "X-Requested-With"
    private static let UID_REQUEST_FORMAT = "uid=%@"
    
    // MARK: Properties
    private let session: URLSession
    
    /// Init a user tracker for tracking user event
    /// - parameter timeoutInterval: the value for timeout. This field is optional.
    ///                              If the timeout value is not specified, it will be the default value 10.0
    public init(timeoutInterval: TimeInterval = UserTracker.DEFAULT_TIMEOUT_INTERVAL) {
        self.session = UserTracker.configSession(with: timeoutInterval)
    }
    
    /// Configure the session for sending tracking request
    private static func configSession(with timeoutInterval: TimeInterval) -> URLSession{
        var sessionConfig: URLSessionConfiguration
        sessionConfig = URLSessionConfiguration.default
        sessionConfig.allowsCellularAccess = true
        sessionConfig.timeoutIntervalForRequest = timeoutInterval
        sessionConfig.timeoutIntervalForResource = timeoutInterval
        
        // Configuring caching behavior for the default session
        let cachesDirectoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let cacheURL = cachesDirectoryURL.appendingPathComponent("trackingCache")
        let diskPath = cacheURL.path
        
        let cache = URLCache(memoryCapacity:16384, diskCapacity: 268435456, diskPath: diskPath)
        sessionConfig.urlCache = cache
        sessionConfig.requestCachePolicy = .useProtocolCachePolicy
        
        return URLSession(configuration: sessionConfig)
    }
    
    /// Track an user event
    /// - parameter params: the parameters that need to be tracked
    /// - parameter handler: the handler to execute after the track request is sent
    public func track(params: TrackingParams,
                      handler:  ( (_ success: Bool, Error?) -> Void )?) -> Void {
        // Get request URL
        let requestUrl = RequestSerializer.generateRequestUrl(
                                                            baseUrl: UserTracker.VISENZE_TRACK_URL,
                                                            apiEndPoint: UserTracker.VISENZE_TRACK_ENDPOINT,
                                                            trackingParams: params)
        
        guard let url = URL(string: requestUrl) else {
            fatalError("Invalid request URL")
        }
        
        // Form request
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: session.configuration.timeoutIntervalForRequest)
        let deviceUid = UidHelper.uniqueDeviceUid()
        request.addValue(String(format: UserTracker.UID_REQUEST_FORMAT, deviceUid),
                         forHTTPHeaderField: UserTracker.HTTP_COOKIE_FIELD)
        request.addValue(UserTracker.USER_AGENT , forHTTPHeaderField: UserTracker.USER_AGENT_HEADER )

        // Send request
        session.dataTask(with: request as URLRequest, completionHandler:{
            (data, response, error) in
            guard let handler = handler else {
                return
            }
            let hasError = (error == nil)
            handler(hasError, error)
        }).resume()
    }
    
    
}
