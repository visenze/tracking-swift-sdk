//
//  TrackingParams.swift
//  UserTrackingSDK
//
//  Created by visenze on 22/5/18.
//  Copyright © 2018 ViSenze. All rights reserved.
//

/**
 Parameters you want to track in a user event
 */
public class TrackingParams {
    /// The action of the user event you want to track
    /// e.g. "add-to-wish-list", "view", "click"
    /// This is a required parameter
    private let action: String
    
    /// The request id of the current search provided
    /// by ViSenze search service
    /// This is a required parameter
    private let requestId: String
    
    /// User ID generated from your platform
    /// e.g. account ID of the user
    private let cuid: String?
    
    /// Other custom parameters that you want to track
    private let customTrackingParams: [String: String]?
    
    /// Initialize track parameters
    /// Note: the parameters action, requestId and cid are compulsory
    /// - parameter action: The action of the user event you want to track
    ///                     e.g. "add-to-wish-list", "view", "click"
    /// - parameter requestId: The request id of the current search provided by ViSenze search service
    /// - parameter cuid: User ID generated from your platform. e.g. account ID of the user
    /// - parameter customTrackingParams: Other custom parameters that you want to track
    public init(action: String, requestId: String, cuid: String?, customTrackingParams: [String: String]?) {
        self.action = action
        self.requestId = requestId
        self.cuid = cuid
        self.customTrackingParams = customTrackingParams
    }
    
    /// Initialize track parameters
    /// - parameter action: The action of the user event you want to track
    ///                     e.g. "add-to-wish-list", "view", "click"
    /// - parameter requestId: The request id of the current search provided by ViSenze search service
    /// - parameter cuid: User ID generated from your platform. e.g. account ID of the user
    public convenience init(action: String, requestId: String, cuid: String) {
        self.init(action: action, requestId: requestId, cuid: cuid, customTrackingParams: nil)
    }
    
    /// Initialize track parameters
    /// - parameter action: The action of the user event you want to track
    ///                     e.g. "add-to-wish-list", "view", "click"
    /// - parameter requestId: The request id of the current search provided by ViSenze search service
    /// - parameter customTrackingParams: Other custom parameters that you want to track
    public convenience init(action: String, requestId: String, customTrackingParams: [String: String]) {
        self.init(action: action, requestId: requestId, cuid: nil, customTrackingParams: customTrackingParams)
    }
    
    /// Initialize track parameters
    /// - parameter action: The action of the user event you want to track
    ///                     e.g. "add-to-wish-list", "view", "click"
    /// - parameter requestId: The request id of the current search provided by ViSenze search service
    public convenience init(action: String, requestId: String) {
        self.init(action: action, requestId: requestId, cuid: nil, customTrackingParams: nil)
    }
    
    /// Get a dictionary of all the parameters and their
    /// corresponding values that need to be tracked
    func toDict(with initParams: [String: String]) -> [String: String] {
        
        var dict : [String: String] = [:]
        dict["action"] = self.action
        dict["reqid"] = self.requestId
        
        if let cuid = self.cuid {
            dict["cuid"] = cuid
        }
        
        if let customTrackingParams = self.customTrackingParams {
            // Add items in dictionary customTrackingParams to  dictionary dict
            customTrackingParams.forEach { (k,v) in dict[k] = v }
        }
        
        // Add init params to dictionary
        initParams.forEach { (k,v) in dict[k] = v }
        
        return dict;
        
    }
}

