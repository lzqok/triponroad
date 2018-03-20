//
//  BaseModel.swift
//  Triponroad
//
//  Created by unicorn on 2018/3/19.
//  Copyright © 2018年 unicorn. All rights reserved.
//

import UIKit
import SwiftyJSON
class BaseModel: NSObject {
    var code = 0
    var data:JSON?
    var msg : String?
    init(jsonData:JSON){
        code = jsonData[RESULT_CODE].intValue
        msg = jsonData[RESULT_MESSAGE].stringValue
        data = jsonData[RESULT_DATA]
    }
}
