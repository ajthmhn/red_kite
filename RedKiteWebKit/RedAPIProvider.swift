//
//  RedAPIProvider.swift
//  Red
//
//  Created by Isletsystems on 22/09/16.
//  Copyright © 2016 Red. All rights reserved.
//

import UIKit
import Moya
import Alamofire

public struct RedAPIProviderFactory {
    
    
    static let endpointsClosure:(RedAPI)->Endpoint = { (target: RedAPI) -> Endpoint in
        
        var endpoint: Endpoint = Endpoint(
            url: url(target),
            sampleResponseClosure:{ .networkResponse(200, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
            //            task: target.task
        )
        
        // Sign all non-SignIn requests as they need the SessionID to proceed
        switch target {
        case .logIn,.signUp:
            return endpoint
        default:
            var header = ""
            if let token = RedAPIFacade.shared.session?.token {
                header = "\(token)"
            }
            return endpoint.adding(newHTTPHeaderFields: ["userToken": header])
        }
    }
    
    public static var offlineMode : Bool = false
    
    static func stubOrNot(_: RedAPI) -> Moya.StubBehavior {
        return offlineMode ? .immediate : .never //.delayed(seconds: 1.0)
    }
    
    public static func DefaultProvider() -> MoyaProvider<RedAPI> {
        return MoyaProvider<RedAPI>(endpointClosure: endpointsClosure,
                                      stubClosure: stubOrNot,
                                      plugins: RedAPIProviderFactory.plugins)
    }
    
    public static func StubbingProvider() -> MoyaProvider<RedAPI> {
        return MoyaProvider(endpointClosure: endpointsClosure, stubClosure: MoyaProvider.immediatelyStub)
    }
    
    fileprivate struct SharedProvider {
        static var instance = RedAPIProviderFactory.DefaultProvider()
    }
    
    public static var sharedProvider: MoyaProvider<RedAPI> {
        get {
            return SharedProvider.instance
        }
        
        set (newSharedProvider) {
            SharedProvider.instance = newSharedProvider
        }
    }
    
    static var plugins: [PluginType] {
        return [
            RedAPINetworkLogger(whitelist: { (target:TargetType) -> Bool in
                switch target as! RedAPI {
                case .logIn: return true
                default: return true
                }
            }, blacklist: { (target:TargetType) -> Bool in
                switch target as! RedAPI {
                case .logIn(_): return true
                default: return false
                }
            })
        ]
    }
}
