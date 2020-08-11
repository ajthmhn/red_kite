
//  RedAPIConfig.swift
//  RedManager
//
//  Created by islet on 14/12/16.
//  Copyright © 2016 islet. All rights reserved.
//

import UIKit

public class RedAPIConfig: NSObject {
    
    public struct Notifications {
        
        public static let sessionExpired = "api.sessionId.expired"
        
    }
    
public struct BaseUrl {
    //public static let baseServerpath = "http://127.0.0.1:8008/"
    public static let baseServerpath = "http://Redapp.qa/"
    public static let imageBaseServerpath = "http://Redapp.qa/storage/"
    //public static let baseServerpath = "http://click.whytecreations.in/"
    }
}
