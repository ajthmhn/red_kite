//
//  RedAPISession.swift
//  Red
//
//  Created by Isletsystems on 22/09/16.
//  Copyright © 2016 Red. All rights reserved.
//

import UIKit

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l >= r
    default:
        return !(lhs < rhs)
    }
}


private extension Date {
    var isInPast: Bool {
        let now = Date()
        return self.compare(now) == ComparisonResult.orderedAscending
    }
}

public struct RedAPISession {
    enum DefaultsKeys: String {
        case TokenKey = "RedAPI.TokenKey"
        case TokenExpiry = "RedAPI.TokenExpiry"
        case RefreshTokenKey = "RedAPI.RefreshTokenKey"
        case TokenType = "RedAPI.TokenType"
        case OTPVerified = "YoKitchenAPI.OTPVerified"
    }
    
    // MARK: - Initializers
    
    let defaults: UserDefaults
    
    public init(defaults:UserDefaults) {
        self.defaults = defaults
    }
    
    public init() {
        self.defaults = UserDefaults.standard
    }
    
     public var currentUser: User?

    public var token: String? {
        get {
            let key = defaults.string(forKey: DefaultsKeys.TokenKey.rawValue)
            //debugPrint("token = \(key)")
            return key
        }
        set(newToken) {
            defaults.set(newToken, forKey: DefaultsKeys.TokenKey.rawValue)
            defaults.synchronize()
            //let key = defaults.string(forKey: DefaultsKeys.TokenKey.rawValue)
            //debugPrint("set to token = \(key)")
        }
    }
    
    public var tokenType: String? {
        get {
            let key = defaults.string(forKey: DefaultsKeys.TokenType.rawValue)
            //debugPrint("token type = \(key)")
            return key
        }
        set(newToken) {
            defaults.set(newToken, forKey: DefaultsKeys.TokenType.rawValue)
            defaults.synchronize()
            //let key = defaults.string(forKey: DefaultsKeys.TokenType.rawValue)
            //debugPrint("set to token type = \(key)")
        }
    }
    
    public var refreshToken: String? {
        get {
            let key = defaults.string(forKey: DefaultsKeys.RefreshTokenKey.rawValue)
            //debugPrint("refresh token = \(key)")
            return key
        }
        set(newToken) {
            defaults.set(newToken, forKey: DefaultsKeys.RefreshTokenKey.rawValue)
            defaults.synchronize()
            //let key = defaults.string(forKey: DefaultsKeys.RefreshTokenKey.rawValue)
            //debugPrint("set to refresh token = \(key)")
        }
    }
    
    public var otp: String? {
        get {
            let key = defaults.string(forKey: DefaultsKeys.OTPVerified.rawValue)
            debugPrint("otp = \(String(describing: key))")
            return key
        }
        set(newToken) {
            defaults.set(newToken, forKey: DefaultsKeys.OTPVerified.rawValue)
            defaults.synchronize()
            //let key = defaults.string(forKey: DefaultsKeys.OTPVerified.rawValue)
            //debugPrint("set otp = \(key)")
        }
    }
    
    public var expiry: Date? {
        get {
            return defaults.object(forKey: DefaultsKeys.TokenExpiry.rawValue) as? Date
        }
        set(newExpiry) {
            defaults.set(newExpiry, forKey: DefaultsKeys.TokenExpiry.rawValue)
            defaults.synchronize()
        }
    }
    
    public var expired: Bool {
        if let expiry = expiry {
            return expiry.isInPast
        }
        return true
    }
    
    public var isValid: Bool {
        if let token = token {
            return !token.isEmpty //&& !expired
        }
        
        return false
    }
    
    public var isOTPVerified: Bool {
        if let otp = otp {
            if otp == "false" {
                return false
            }else {
                return true
            }
        }
        
        return false
    }
    
}

