# tracking-swift-sdk
ViSearch User Action Tracking SDK (Swift)

## How to use this SDK
1. Create a `UserEventTracker` object
2. Create a `TrackingParams` object containing tracking information
3. Use the `UserEventTracker` object to track the `TrackingParams` object

Example:
```swift
// Initialize a new UserEventTracker with your initParams to track this action
// For ViSearch please use the key "cid" with value app key
// For UGC please use the key "campaign_id" with value campaign ID
let initParams: [String: String] = ["cid": "xxx"]
let userEventTracker = UserTracker(initParams: initParams)
userEventTracker.track(params: trackingParams, handler: yourCompletionHandler)

  // Wrap the information you want to track into a TrackingParams object
  let action = "purchase"
  let requestId = "Your_requestid"
  let trackingParams = TrackingParams(action: action, requestId: requestId)

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

let trackingParamsWithCuid = TrackingParams(action: "action", requestId: "Your_request_id",
cuid: "Your_cuid")  

let trackingParamsWithCustomParams = TrackingParams(action: "action", requestId: "Your_request_id",
customTrackingParams: customParams)

let trackingParamsWithBoth = TrackingParams(action: "action", requestId: "Your_request_id",
cuid: "Your_cuid", customTrackingParams: customParams)
```
- Don't include space in the name of the key for you custom tracking parameters in `TrackingParams` class.

### Class `UserEventTracker`
By using the alternative constructors, you can set your own
1. endpoint for tracking. If it is not specified, the default endpoint http://track.visenze.com/__aq.gif will be used.
2. the timeout value. If it is not specified, the default value 10 second will be used.

For example:
```swift

let userTracker = UserTracker(initParams: initParams)

let userTrackerWithCustomTimeoutValue = UserTracker(timeoutInterval: yourTimeInterval,
initParams: initParams)

let userTrackerWithCustomEndpoint = UserTracker(initParams: initParams, trackingUrl: "Your_URL",
trackEndpoint: "Your_endpoint")

let userTrackerWithBoth = UserTracker(timeoutInterval: yourTimeInterval, initParams: initParams,
trackingUrl: "Your_URL", trackEndpoint: "Your_endpoint")
```
