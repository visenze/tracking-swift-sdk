# tracking-swift-sdk
ViSearch User Action Tracking SDK (Swift)

## How to use this SDK
1. Create a `UserEventTracker` object
2. Create a `TrackingParams` object containing tracking information
3. Use the `UserEventTracker` object to track the `TrackingParams` object

Example:
```swift

  // Wrap the information you want to track into a TrackingParams object
  let action = "purchase"
  let requestId = "Your_requestid"
  let trackingParams = TrackingParams(action: action, requestId: requestId)

  // Initialize a new UserEventTracker with your app key to track this action
  let appKey = "Your_app_key"
  let userEventTracker = UserTracker(appKey: appKey)
  userEventTracker.track(params: trackingParams, handler: yourCompletionHandler)

```

## Note to developer: 

### Class `TrackingParams`
By using the alternative constructors, you can set your own
1. custom parameters 
2. the user ID generated from your platform 
(e.g. account ID of the user) for tracking 

  For example:
  ```swift
    let customParams: [String: String] = ["Your_custom_param": "Value"]
    
    let trackingParamsWithCuid = TrackingParams(action: "action", requestId: "Your_request_id", cuid: "Your_cuid")  
    
    let trackingParamsWithCustomParams = TrackingParams(action: "action", requestId: "Your_request_id", customTrackingParams: customParams)
    
    let trackingParamsWithCuidAndCustomParams = TrackingParams(action: "action", requestId: "Your_request_id", cuid: "Your_cuid", customTrackingParams: customParams)
  ```
- Don't include space in the name of the key for you custom tracking parameters in `TrackingParams` class. 

### Class `UserEventTracker`
By using the alternative constructors, you can set your own
1. endpoint for tracking. If it is not specified, the default endpoint http://track.visenze.com/__aq.gif will be used.
2. the timeout value. If it is not specified, the default value 10 second will be used.

  For example:
  ```swift
    let timeInterval = 20.0
    
    let userTracker = UserTracker(appKey: "Your_app_key")
    
    let userTrackerWithCustomTimeoutValue = UserTracker(timeoutInterval: timeInterval, appKey: "Your_app_key")
    
    let userTrackerWithCustomEndpoint = UserTracker(appKey: "Your_app_key", trackingUrl: "Your_URL", trackEndpoint: "Your_endpoint")
    
    let userTrackerWithCustomTimeoutAndEndpoint = UserTracker(timeoutInterval: timeInterval, appKey: "Your_app_key", trackingUrl: "Your_URL", trackEndpoint: "Your_endpoint")
  ```
