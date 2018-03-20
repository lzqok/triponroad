//
//  LoginVC.swift
//  Triponroad
//
//  Created by unicorn on 2018/3/15.
//  Copyright © 2018年 unicorn. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
class LoginVC: UIViewController {

    var tf_userName : UITextField = UITextField()
    var tf_password : UITextField = UITextField()
    var btn_submit : UIButton = UIButton()
    var im_background : UIImageView = UIImageView()
    var viewModel:LoginViewModel?
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
        setAutoFrame()
        bindViewModel()
    }
    
    func setUI() {
        im_background.image = #imageLiteral(resourceName: "login")
        im_background.clipsToBounds = true
        im_background.contentMode = .scaleAspectFill
        self.view.addSubview(im_background)
        tf_userName.text = "lzqok"
        tf_userName.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
        self.view.addSubview(tf_userName)
        tf_password.text = "Lzqok123456"
        tf_password.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
        self.view.addSubview(tf_password)
        btn_submit.backgroundColor = UIColor.blue
        btn_submit.setTitle("Login", for: .normal)
        btn_submit.setTitleColor(UIColor.white, for: .normal)
        self.view.addSubview(btn_submit)
    }
    
    func setAutoFrame() {
        im_background.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        tf_userName.snp.makeConstraints { (make) in
            make.bottom.equalTo(tf_password.snp.top).offset(-15)
            make.left.right.height.equalTo(tf_password)
        }
        
        tf_password.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.view.snp.centerY)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(45)
        }
        
        btn_submit.snp.makeConstraints { (make) in
            make.top.equalTo(tf_password.snp.bottom).offset(15)
            make.left.right.height.equalTo(tf_password)
        }
        
    }
    
    func bindViewModel() {
        
        viewModel = LoginViewModel.init(mobile: tf_userName.rx.text.orEmpty.asObservable(), password: tf_password.rx.text.orEmpty.asObservable(),loginTap: btn_submit.rx.tap.asObservable())
        
        viewModel?.loginEnable.subscribe(onNext: { (x) in
            self.btn_submit.isEnabled = x
        }).disposed(by: disposeBag)
        
        viewModel?.signedIn.subscribe(onNext: { (isLogin) in
            if isLogin {
                print("登录成功")
                self.mainView()
            }else {
                print("登录失败")
            }
        }).disposed(by: disposeBag)
        
    }
    
    func mainView() {
        let vc = TRTabBarVC()
        TRAppDelegate.window?.rootViewController = vc
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
