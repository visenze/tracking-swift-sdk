//
//  UidHelper.swift
//  UserTrackingSDK
//
//  Created by visenze on 23/5/18.
//  Copyright © 2018 ViSenze. All rights reserved.
//
import UIKit
/**
 Helper class for retriving uid
 which is the unique device ID
 */
class UidGetter {
    
    /// Internal key for storing uid
    static let UID_KEY = "uid"
    
    /// Retrieve unique device uid and store into userDefaults
    /// this is needed for tracking API to identify various actions
    /// - returns: unique device uid if fail to get returns an empty string
    public static func uniqueDeviceUid() -> String {
        // Get the uid from local storage
        let storeUid = SettingHelper.getStringSettingProp(propName: UID_KEY)
        
        // If there is no uid stored in local storage, get the device id 
        // and store in local storage
        if storeUid == nil || storeUid?.characters.count == 0 {
            let deviceId = UIDevice.current.identifierForVendor?.uuidString;
            
            SettingHelper.setSettingProp(propName: UID_KEY, newValue: deviceId!)
            
            return deviceId ?? ""
        }
        return storeUid ?? ""
    }
}


/**
 Helper class for storing uid to user default(local storage)
 */
private class SettingHelper {
    
    
    /// Set a property , store in userDefault
    /// - parameter propName: property name
    /// - parameter newValue: new value for property
    static func setSettingProp(propName: String , newValue: Any?) -> Void {
        let userDefault = UserDefaults.standard
        userDefault.set(newValue, forKey: propName)
    }
    
    
    /// Retrieve setting in userdefault as String
    /// - parameter propName: name of property
    /// - returns: value as String?
    static func getStringSettingProp (propName: String) -> String? {
        let userDefault = UserDefaults.standard
        return userDefault.string(forKey: propName)
    }
}
