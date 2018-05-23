//
//  UidHelper.swift
//  UserTrackingSDK
//
//  Created by visenze on 23/5/18.
//  Copyright © 2018 ViSenze. All rights reserved.
//

/**
 Helper class for retriving uid
 which is the unique device ID
 */
class UidHelper {
    
    /// Internal key for storing uid
    static let UID_KEY = "uid"
    
    /// Retrieve unique device uid and store into userDefaults
    /// this is needed for tracking API to identify various actions
    /// - returns: unique device uid
    public static func uniqueDeviceUid() -> String {
        let storeUid = SettingHelper.getStringSettingProp(propName: UID_KEY)
        
        if storeUid == nil || storeUid?.characters.count == 0 {
            let deviceId = UIDevice.current.identifierForVendor?.uuidString;
            
            // store in the setting
            SettingHelper.setSettingProp(propName: UID_KEY, newValue: deviceId!)
            
            return deviceId!
        }
        
        return storeUid!
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
