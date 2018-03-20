//
//  Extension+String.swift
//  Triponroad
//
//  Created by unicorn on 2018/3/19.
//  Copyright © 2018年 unicorn. All rights reserved.
//

import UIKit
extension String {
    struct constVar {
        static let tempLabel = UILabel()
    }
    
    func getStringSize(_ size:CGSize,font:UIFont)->CGSize {
        constVar.tempLabel.text = self
        constVar.tempLabel.font = font
        return constVar.tempLabel.sizeThatFits(size)
    }
}
