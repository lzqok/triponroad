//
//  UserApi.swift
//  Triponroad
//
//  Created by unicorn on 2018/3/15.
//  Copyright © 2018年 unicorn. All rights reserved.
//

import UIKit
import Alamofire
enum LoginApi {
    case Login(moblie:String?,password:String?)
}

extension LoginApi:Request {
    var method: HTTPMethod {
        return HTTPMethod.post
    }
    
    var hub: Bool {
        return false
    }
    
    var path:String{
        switch self {
        case .Login(_):
            return "/login"
        }
    }
    
    var parameters:[String:Any]? {
        switch self {
        case .Login(let mobile, let password):
            return ["username":mobile as Any,"password":password as Any]
        }
    }
}
