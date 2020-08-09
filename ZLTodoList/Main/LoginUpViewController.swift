//
//  LoginUpViewController.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/13.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit
import SnapKit

class LoginUpViewController: UIViewController {
    private lazy var navBack: UIButton = {
        let btn = UIButton()
        let img = UIImage.autoLoadImageFromResource(withname: "gg")
        btn.setImage(img, for: .normal)
        return btn
    }()
    
    private lazy var navInfo: UIButton = {
        let btn = UIButton()
        let img = UIImage.autoLoadImageFromResource(withname: "fc")
        btn.setImage(img, for: .normal)
        return btn
    }()
    
    private lazy var navView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        // self.navigationItem.titleView = view
        view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: kNavgationBarH)
        view.addSubview(navBack)
        view.addSubview(navInfo)
        navBack.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20 * kScale)
            make.centerY.equalToSuperview()
        }
        
        navInfo.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20 * kScale)
            make.centerY.equalToSuperview()
        }
        
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var subTitles: UIView = { UIView() }()
    
    private func addSubTitles() {
        let label = UILabel()
        label.font = UIFont.customFont(customType: .Avenir, ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "By signing up you agree to our Teams and Conditions of Use"
        //        let btn1 = UIButton()
        //        let btn2 = UIButton()
        //        let and = UILabel()
        //        let bmView = UIView()
        //        and.text = "and"
        //        subTitles.addSubview(label)
        //        bmView.addSubview(btn1)
        //        bmView.addSubview(btn2)
        //        bmView.addSubview(and)
        //        subTitles.addSubview(bmView)
        label.textAlignment = .center
        subTitles.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
        }
    }
    
    
    /// 第三方登录 推特
    private var ttLogin: UIButton!
    
    /// 第三方登录 谷歌
    private var ggLogin: UIButton!
    
    /// 第三方登录 脸书
    private var fcLogin: UIButton!
    
    private var othersLoginButtonView: UIView = { UIView() }()
    
    private var bottomSignUpBtn: RoundUIButton = {
        let btn = RoundUIButton(title: "I have an account", borderWidth: nil, textColor: UIColor(red: 0.18, green: 0.18, blue: 0.18,alpha:1))
        btn.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        btn.titleLabel?.font = UIFont.customFont(customType: .Montserrat, ofSize: 16)
        return btn
    }()
    
    private var toltip: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(customType: .Avenir, ofSize: 16)
        label.text = "Or sign in with social networks"
        return label
    }()
    
    private func addSubviews(){
        // 添加自定义的navigationBar
        // self.view.addSubview(navView)
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "hello"
        self.view.addSubview(contentView)
        let title = UILabel()
        title.font = UIFont.customFont(customType: .Montserrat, ofSize: 24)
        title.text = "Sign up"
        contentView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50 * kScaleY)
            make.height.equalTo(28 * kScaleY)
        }
        
        // 全称 输入框
        let fullname = RoundTextFiled(placeholder: "Full name", isPass: false)
        // 邮件 输入框
        let username = RoundTextFiled(placeholder: "Email", isPass: false)
        // 密码 输入框
        let password = RoundTextFiled(placeholder: "Password", isPass: true)
        
        
        contentView.addSubview(username)
        contentView.addSubview(password)
        contentView.addSubview(fullname)
        fullname.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(49 * kScaleY)
            make.left.equalToSuperview().offset(40 * kScale)
            make.right.equalToSuperview().offset(-40 * kScale)
            make.height.equalTo(44 * kScaleY)
        }
        
        username.snp.makeConstraints { (make) in
            make.top.equalTo(fullname.snp.bottom).offset(15 * kScaleY)
            make.left.equalToSuperview().offset(40 * kScale)
            make.right.equalToSuperview().offset(-40 * kScale)
            make.height.equalTo(44 * kScaleY)
        }
        
        password.snp.makeConstraints { (make) in
            make.top.equalTo(username.snp.bottom).offset(15 * kScaleY)
            make.left.equalToSuperview().offset(40 * kScale)
            make.right.equalToSuperview().offset(-40 * kScale)
            make.height.equalTo(44 * kScaleY)
        }
        
        // 创建按钮
        let createbutton = RoundUIButton(title: "Create an account", borderWidth: nil, textColor: .white)
        createbutton.titleLabel?.font = UIFont.customFont(customType: .Montserrat, ofSize: 18)
        createbutton.backgroundColor = UIColor(red: 0.16, green: 0.4, blue: 1, alpha: 1)
        contentView.addSubview(createbutton)
        createbutton.snp.makeConstraints { (make) in
            make.top.equalTo(password.snp.bottom).offset(15 * kScaleY)
            make.left.equalToSuperview().offset(40 * kScale)
            make.right.equalToSuperview().offset(-40 * kScale)
            make.height.equalTo(44 * kScaleY)
        }
        
        self.view.addSubview(subTitles)
        subTitles.snp.makeConstraints { (make) in
            make.top.equalTo(createbutton.snp.bottom).offset(20 * kScaleY)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(44 * kScaleY)
        }
        addSubTitles()
        
        self.view.addSubview(bottomSignUpBtn)
        bottomSignUpBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(40 * kScale)
            make.right.equalToSuperview().offset(-40 * kScale)
            make.height.equalTo(44 * kScaleY)
            make.bottom.equalToSuperview().offset(-20 * kScaleY)
        }
        bottomSignUpBtn.addTarget(self, action: #selector(toSignup), for: .touchUpInside)
        
        self.view.addSubview(othersLoginButtonView)
        othersLoginButtonView.snp.makeConstraints { (make) in
            make.bottom.equalTo(bottomSignUpBtn.snp.top).offset(-44 * kScaleY)
            make.left.equalToSuperview().offset(40 * kScale)
            make.right.equalToSuperview().offset(-40 * kScale)
            make.height.equalTo(40 * kScaleY)
        }
        
        ttLogin = makeImageButton(imageName: "tt")
        ggLogin = makeImageButton(imageName: "gg")
        fcLogin = makeImageButton(imageName: "fc")
        othersLoginButtonView.addSubview(ttLogin)
        othersLoginButtonView.addSubview(ggLogin)
        othersLoginButtonView.addSubview(fcLogin)
        
        ttLogin.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.height.equalToSuperview()
            make.right.equalTo(othersLoginButtonView.snp.right).dividedBy(3).offset(-15 * kScale)
        }
        ggLogin.snp.makeConstraints { (make) in
            make.width.equalTo(ttLogin.snp.width)
            make.height.equalTo(ttLogin.snp.height)
            make.left.equalTo(ttLogin.snp.right).offset(15)
        }
        fcLogin.snp.makeConstraints { (make) in
            make.width.equalTo(ttLogin.snp.width)
            make.height.equalTo(ggLogin.snp.height)
            make.left.equalTo(ggLogin.snp.right).offset(15)
        }
        
        self.view.addSubview(toltip)
        toltip.snp.makeConstraints { (make) in
            make.bottom.equalTo(othersLoginButtonView.snp.top).offset(-20 * kScaleY)
            make.centerX.equalToSuperview()
            make.height.equalTo(22 * kScaleY)
        }
        
    }
    
    private func makeImageButton(imageName: String) -> UIButton {
        let btn = UIButton()
        let image = UIImage.autoLoadImageFromResource(withname: imageName)
        // btn.backgroundImage(for: .normal)
        btn.setImage(image, for: .normal)
        btn.layer.cornerRadius = 6
        btn.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.91, alpha: 1).cgColor
        btn.layer.borderWidth = 1
        btn.layer.backgroundColor = UIColor.white.cgColor
        return btn
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubviews()
    }
    
    @objc func toSignup(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }


}
