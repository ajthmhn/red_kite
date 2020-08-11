//
//  RedAPIResponse.swift
//  Red
//
//  Created by Isletsystems on 22/09/16.
//  Copyright © 2016 Red. All rights reserved.
//

import UIKit
import SwiftyJSON

public class RedAPIResponse: JSONAble {
    
    public var json: JSON?
    public var data: Data?
    public var success: Bool?
    public var statusCode: Int?
    
    override init() {
    }
    
    init(success: Bool?, data: Data?, json: JSON?) {
        self.success = success
        self.data = data
        if data != nil {
            do{
                self.json = try JSON(data:data!)
            }
            catch {/* error handling here */}
        }
    }
    
    convenience init(jsonData:Data?) {
        self.init(success:true, data: jsonData, json:nil)
    }
    
    convenience init(resp:RedAPIResponse?) {
        self.init(success: resp?.success, data:resp?.data , json: resp?.json)
    }
    
    override public class func fromJSONData(_ jsonData:Data) -> JSONAble {
        var json = JSON()
        do{
            json = try JSON(data:jsonData)
            debugPrint(String.init(data: jsonData, encoding: .utf8) ?? "")
        }
        catch {/* error handling here */}
        return RedAPIResponse(success:true, data:jsonData, json:json)
    }
    
    public func isSuccess()->Bool {
        return success ?? false
    }
    
    public func sessionIDExpired() -> Bool {
        return false
    }
    
}
