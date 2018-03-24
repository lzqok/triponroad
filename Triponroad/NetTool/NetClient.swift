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
        case .CustomError(let msg, let code):
            print("code ---> \(code), msg-->\(msg)")
            LZQNoticePopup.init(image: msg, msg: msg).show()
            break
        }
        return self
    }
}

//请求错误状态
enum HTTPSTATUSCODE:Int {
    case HTTP_200_SUCCESS = 200 //
    case HTTP_400_ERROR = 400
}

let SUCCESSCODE = 0
let RESULT_CODE = "code"
let RESULT_MESSAGE = "msg"
let RESULT_DATA = "data"
    
protocol Request {
    var path:String{get}
    var method:HTTPMethod{get}
    var parameters:[String:Any]?{get}
    var responsModel:String{get}
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
    
    func request<T:Request>(request:T) -> Observable<JSON> {
        return Observable<JSON>.create({ (observer) -> Disposable in
            Alamofire.request(BaseURL+request.path, method: request.method, parameters: request.parameters, encoding: JSONEncoding.default).validate().responseJSON { (response) in
                switch response.result {
                case .success(_):
                    if let result = response.result.value {
                        let data = JSON(result)
                        let code = response.response!.statusCode
                        if code == HTTPSTATUSCODE.HTTP_200_SUCCESS.rawValue {
                            observer.onNext(data)
                            observer.onCompleted()
                        }else {
                           let message = data[RESULT_MESSAGE].stringValue
                           observer.onError(RequestError.CustomError(msg: message, code: code).show())
                        }
                        
                    }else {
                        observer.onError(RequestError.MapperError.show())
                    }
                    
                case .failure(_):
                    let code = response.response!.statusCode
                    if code == HTTPSTATUSCODE.HTTP_400_ERROR.rawValue {
                        if let result = response.data {
                            let data = JSON(result)
                            
                            let message = data[RESULT_MESSAGE].stringValue
                            observer.onError(RequestError.CustomError(msg: message, code: code).show())
                        }else{
                           observer.onError(RequestError.HTTPError.show())
                        }
                        

                    }else{
                       observer.onError(RequestError.HTTPError.show())
                    }
                }
            }
            
            return Disposables.create{
                
            }
        })
        
    }
}

