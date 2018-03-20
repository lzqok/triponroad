//
//  UserInfoModel.swift
//  Triponroad
//
//  Created by unicorn on 2018/3/19.
//  Copyright © 2018年 unicorn. All rights reserved.
//

import UIKit
import SwiftyJSON
class UserInfoModel: BaseModel {
    var username : String?
    var url : String?
    var email : String?
    var token : String?
    
    override init(jsonData:JSON){
        super.init(jsonData: jsonData)
        username = data?["username"].stringValue
        url = data?["url"].stringValue
        email = data?["email"].stringValue
        token = data?["token"].stringValue
    }
}

