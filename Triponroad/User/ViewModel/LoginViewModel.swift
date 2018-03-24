//
//  LoginViewModel.swift
//  Triponroad
//
//  Created by unicorn on 2018/3/15.
//  Copyright © 2018年 unicorn. All rights reserved.
//

import UIKit
import RxSwift
class LoginViewModel: NSObject {
    var mobileValidate : Observable<Bool>
    var passwordValidate : Observable<Bool>
    var loginEnable : Observable<Bool>
    var signedIn : Observable<Bool>
    init(mobile : Observable<String>,password : Observable<String>,loginTap:Observable<Void>) {
//        super.init()
        mobileValidate = mobile.map ({ (str) -> Bool in
            return str.count > 0 && str.count <= 11
        }).share(replay: 1)
        
        passwordValidate = password.map({ (str) -> Bool in
            return str.count > 0
        }).share(replay:1)
        
        loginEnable = Observable.combineLatest(mobileValidate,passwordValidate){($0,$1)}.share(replay: 1).map({ (x,y) -> Bool in
            return x && y
        }).share(replay: 1)
        
        let mobileAndPassword = Observable.combineLatest(mobile,password){($0,$1)}.share(replay: 1)
        
        signedIn = loginTap.withLatestFrom(mobileAndPassword).flatMap { (mobile,password) in
            return NetInstance.request(request: UserApi.Login(moblie: mobile, password: password)).map({(info)->Bool in
                print(info)
                let model = UserInfoModel.init(jsonData: info)
                return true
            }).catchErrorJustReturn(false)
        }
    }
}
