//
//  RedAPIFacade.swift
//  RedManager
//
//  Created by islet on 14/12/16.
//  Copyright © 2016 islet. All rights reserved.
//

//
//  RedAPIFacade.swift
//  Red
//
//  Created by Isletsystems on 22/09/16.
//  Copyright © 2016 Red. All rights reserved.
//

import UIKit
import SwiftyJSON

public typealias RedAPICompletion = (RedAPIResponse?) -> Void

public class RedAPIFacade: NSObject {
    struct RedAPIFacadeConst{
        static let clientId = 2
        static let clientKey = "FEZbPoNvx3vMxP2H1UsP1kCTTVmbxaNlbSuqo7J0"
    }
    public var session : RedAPISession?
    public class var shared : RedAPIFacade {
        struct Singleton {
            static let instance = RedAPIFacade()
        }
        return Singleton.instance
    }
    
    override init() {
        
        RedAPIProviderFactory.offlineMode = false
        session = RedAPISession.init()
    }
    
    public func setOfflineMode(_ flag:Bool) {
        RedAPIProviderFactory.offlineMode = flag
    }
    
    public func signUp(profDet:[String:Any], completion:RedAPICompletion?) {
        RedAPIProviderFactory.sharedProvider.request(.signUp(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = RedAPIResponse.fromJSONData(jsonData) as? RedAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(RedAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
  
    public func login(loginDet:[String:Any], completion:RedAPICompletion?) {
        RedAPIProviderFactory.sharedProvider.request(.logIn(profDetails: loginDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = RedAPIResponse.fromJSONData(jsonData) as? RedAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if moyaResponse.statusCode == 200 {
                        if YKRes.json?["success"].intValue != 0{
                            if YKRes.json != nil{
                                self.extractUserSession(YKRes.json!)
                                self.extractUserDetails(YKRes.json!)
                            }
                           
                        }
                    } else {
                        //reset it otherwise
                        self.resetSession()
                    }
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(RedAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    public func resetSession() {
        self.session?.token = nil
    }
    
    public func extractUserSession(_ json:JSON) {
        let data = json["user"]
        self.session?.token = data["login_token"].stringValue
    }
    
    public func extractUserDetails(_ json:JSON) {
        let user = User(json:json["user"])
        self.session?.currentUser = user
    }

    // MARK: - image path
    public func urlForImage(imagePath:String) -> URL?{
        let path = RedAPIConfig.BaseUrl.baseServerpath + "uploads/" + imagePath
        return URL(string: path)
    }
}


