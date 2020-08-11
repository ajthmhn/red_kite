//
//  User.swift
//  PartyWebKit
//
//  Created by WC_Macmini on 13/11/19.
//  Copyright © 2019 WC_Macmini. All rights reserved.
//

import UIKit
import SwiftyJSON

public class User: JSONAble {
    public var userId : Int?
    public var userName : String?
    public var image : String?
    public var emailId : String?
    public var phone : String?
    public var dob : String?
    public var IdNo : String?
    public var pboxNo : String?
        
    public init(json:JSON) {
        userId = json["id"].int
        userName = json["name"].string
        image = json["photo"].string
        emailId = json["email"].string
        phone = json["phone"].intToSafeString()
        dob = json["dob"].string
        IdNo = json["id_no"].string
        pboxNo = json["po_box"].string
    }
        
    public func dicValue() -> [String:Any] {
        var userDic = [String:Any]()
        userDic["id"] = userId
        userDic["name"] = userName
        userDic["photo"] = image
        userDic["email"] = emailId
        userDic["phone"] = phone
        userDic["dob"] = dob
        userDic["id_no"] = IdNo
        userDic["po_box"] = pboxNo
        return userDic
    }
}
    


