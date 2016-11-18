//
//  UserInfo.swift
//  test
//
//  Created by 陈小爷 on 2016/10/21.
//  Copyright © 2016年 陈小爷. All rights reserved.
//
import Foundation
import SwiftyJSON


class UserInfo : NSObject{


    
    var content : Content?
    var state : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json == JSON.null{
            return
        }
        let contentJson = json["content"]
        if contentJson != JSON.null{
            content = Content(fromJson: contentJson)
        }
        state = json["state"].stringValue
    }
    class Content{
        
        var uId : String!
        var uName : String!
        var uPassword : String!
        var uPhone : String!
        var uRealname : String!
        var uSex : Int!
        var uUnit : String!
        var userToken:String!
        
        /**
         * Instantiate the instance using the passed json values to set the properties values
         */
        init(fromJson json: JSON!){
            if json == JSON.null{
                return
            }
            uId = json["u_id"].stringValue
            uName = json["u_name"].stringValue
            uPassword = json["u_password"].stringValue
            uPhone = json["u_phone"].stringValue
            uRealname = json["u_realname"].stringValue
            uSex = json["u_sex"].intValue
            uUnit = json["u_unit"].stringValue
            userToken = json["userToken"].stringValue
        }
    }
}
