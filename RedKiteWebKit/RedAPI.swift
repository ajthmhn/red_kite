//
//  RedAPI.swift
//  Red
//
//  Created by Isletsystems on 22/09/16.
//  Copyright © 2016 Red. All rights reserved.
//

import UIKit
import Moya

public enum RedAPI {
    case signUp(profDetails:[String:Any])
    case logIn(profDetails:[String:Any])
}

extension RedAPI: TargetType {
    
    public var headers: [String : String]? {
        return nil
    }
    
    var base: String {
        return  RedAPIConfig.BaseUrl.baseServerpath + "api/"
        
    }
    
    public var baseURL: URL {
        return URL(string: base)!
    }

    public var path: String {
        switch self {
        case .signUp(_):
            return "sign-up"
        case .logIn(_):
            return "login"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case    .signUp(_),
                .logIn(_):
              
            return .post
//        case
//            return .get
//
//            return .put
     
        
        
        }
    }
    
    public var parameters: [String:Any]? {
        switch self {
        case .signUp(let profDet):
            return profDet
        case .logIn(let loginDet):
            return loginDet
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .signUp:
            return stubbedResponse("")
        case .logIn:
            return stubbedResponse("")
        }
    }
    
    public var task: Task {
//        switch self {
//        case .signUp(let params):
//            var formData = [MultipartFormData]()
//            for (key, value) in params {
//                if let imgData = value as? Data {
//                    formData.append(MultipartFormData(provider: .data(imgData), name: key, fileName: "testImage.jpg", mimeType: "image/jpeg"))
//                } else {
//                    formData.append(MultipartFormData(provider: .data("\(value)".data(using: .utf8)!), name: key))
//                }
//            }
//            return .uploadMultipart(formData)
//        default:
//            if(parameters != nil){
//                return Task.requestParameters(parameters: (parameters)!, encoding: parameterEncoding)
//            }else{
//                return Task.requestPlain
//            }
//        }
        
        if(parameters != nil){
                      return Task.requestParameters(parameters: (parameters)!, encoding: parameterEncoding)
                  }else{
                      return Task.requestPlain
                  }
    }
    
    public var parameterEncoding: ParameterEncoding {
        switch self {
        case  .logIn(_):
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
}

func stubbedResponse(_ filename: String) -> Data! {
    let bundleURL = Bundle.main.bundleURL
    
    let path = bundleURL.appendingPathComponent("Frameworks/RedAppKit.framework/\(filename).json") //bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: path))
}

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
