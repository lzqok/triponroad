//
//  LZQNoticePopup.swift
//  Triponroad
//
//  Created by unicorn on 2018/3/19.
//  Copyright © 2018年 unicorn. All rights reserved.
//

import UIKit

class LZQNoticePopup: UIView {
    var info_image = UIImageView()
    var info_label = UILabel()
    private var msg = ""
    private var image = ""
    init(image:String,msg:String) {
        super.init(frame: .zero)
        self.msg = msg
        setUI()
        setAutoFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.info_image.image = UIImage.init(named: image)
        self.addSubview(info_image)
        self.info_label.text = msg
        self.info_label.textColor = WhiteColor
        self.info_label.font = KFont15
        self.info_label.textAlignment = .center
        self.addSubview(info_label)
    }
    
    
    func setAutoFrame() {
        
        self.info_image.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.centerX.equalTo(self.snp.centerX)
            make.width.height.lessThanOrEqualTo(50)
        }
        
        self.info_label.snp.makeConstraints { (make) in
            make.top.equalTo(self.info_image.snp.bottom).offset(5)
            make.left.equalTo(5)
            make.right.equalTo(-5)
        }
    }
    
    func show() {
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
        
        var msgSize = msg.getStringSize(CGSize.init(width: ScreenWidth - 40, height: CGFloat(MAXFLOAT)), font: KFont15)
        if msgSize.width < 120*TRScale {
            msgSize.width = 120*TRScale
        }
        
        if msgSize.height < 80*TRScale {
            msgSize.height = 80*TRScale
        }
        
        self.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(window!)
            make.width.equalTo(msgSize.width)
            make.height.equalTo(msgSize.height)
        }
        
        self.perform(#selector(dismiss), with: nil, afterDelay: 3)
    }
    
    @objc func dismiss() {
        self.removeFromSuperview()
    }
}
