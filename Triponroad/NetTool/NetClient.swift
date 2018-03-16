//
//  NetClient.swift
//  Triponroad
//
//  Created by unicorn on 2018/3/15.
//  Copyright © 2018年 unicorn. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import SwiftyJSON
enum RequestError:Swift.Error {
    case HTTPError
    case MapperError
    case CustomError(msg:String,code:Int)
    func show() -> RequestError {
        switch self {
        case .HTTPError:break
        case .MapperError:break
        case .CustomError( _, _):break
        }
        return self
    }
}

let SUCCESSCODE = 0
let RESULT_CODE = "code"
let RESULT_MESSAGE = "msg"
let RESULT_DATA = "result"
    
protocol Request {
    var path:String{get}
    var method:HTTPMethod{get}
    var parameters:[String:Any]?{get}
    var hub:Bool{get}
}

let BaseURL = "http://10.0.0.165:8000"


let NetInstance = NetClient.netClient

class NetClient: NSObject {
    
    class var netClient:NetClient {
        struct Static {
            static let instance = NetClient()
        }
        return Static.instance
    }
    
    func request<T:Request>(request:T) -> Observable<[String:Any]> {
        return Observable<[String:Any]>.create({ (observer) -> Disposable in
            Alamofire.request(BaseURL+request.path, method: request.method, parameters: request.parameters, encoding: JSONEncoding.default).validate().responseJSON { (response) in
                switch response.result {
                case .success(_):
                    if let result = response.result.value {
                        let data = JSON(result)
                        if let code = data[RESULT_CODE].intValue as? Int {
                            if code == SUCCESSCODE {
                                observer.onNext(data[RESULT_DATA].dictionaryValue)
                                observer.onCompleted()
                            }else {
                               let message = data[RESULT_MESSAGE].stringValue
                               observer.onError(RequestError.CustomError(msg: message, code: code).show())
                            }
                        }else {
                            observer.onError(RequestError.MapperError.show())
                        }
                    }else {
                        observer.onError(RequestError.MapperError.show())
                    }
                case .failure(_):
                    observer.onError(RequestError.HTTPError.show())
                }
            }
            
            return Disposables.create{
                
            }
        })
        
    }
}
