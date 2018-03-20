//
//  TRFont.swift
//  Triponroad
//
//  Created by unicorn on 2018/3/19.
//  Copyright © 2018年 unicorn. All rights reserved.
//

import UIKit

func scaleFont(_ fontSize:CGFloat) -> UIFont {
    let font = ScreenWidth / 375 * fontSize
    return UIFont.systemFont(ofSize: font)
}

let KFont10 = scaleFont(10)
let KFont11 = scaleFont(11)
let KFont12 = scaleFont(12)
let KFont13 = scaleFont(13)
let KFont14 = scaleFont(14)
let KFont15 = scaleFont(15)
let KFont16 = scaleFont(16)
let KFont17 = scaleFont(17)
let KFont18 = scaleFont(18)
let KFont19 = scaleFont(19)
let KFont20 = scaleFont(20)
let KFont21 = scaleFont(21)
let KFont22 = scaleFont(22)
let KFont23 = scaleFont(23)
let KFont24 = scaleFont(24)
let KFont25 = scaleFont(25)
