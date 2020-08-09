//
//  LoginViewController.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/13.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    private lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.autoLoadImageFromResource(withname: "Logo")
        imageView.backgroundColor = .white
        imageView.layer.shadowColor = UIColor(red: 0.1, green: 0.1, blue: 0.11, alpha: 0.14).cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 5)
        imageView.layer.shadowOpacity = 1
        imageView.contentMode = .center
        imageView.layer.shadowRadius = 10
        return imageView
    }()
    
    private var titles: UIView = {
        let container = UIView()
        return container
    }()
    
    private var forgetPassword: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 0.16, green: 0.4, blue: 1,alpha:1), for: .normal)
        button.setTitle("Forgot password?", for: .normal)
        button.titleLabel?.font = UIFont.customFont(customType: .Avenir, ofSize: 16)
        return button
    }()
    
    private var bottomSignUpBtn: RoundUIButton = {
        let btn = RoundUIButton(title: "Sign up", borderWidth: nil, textColor: UIColor(red: 0.18, green: 0.18, blue: 0.18,alpha:1))
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
    
    private var othersLoginButtonView: UIView = {
        let view = UIView()
        return view
    }()
    
    /// 第三方登录 推特
    private var ttLogin: UIButton!
    
    /// 第三方登录 谷歌
    private var ggLogin: UIButton!
    
    /// 第三方登录 脸书
    private var fcLogin: UIButton!
    
    /// 生成带icon的button
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
    
    private func addSubviews() {
        self.view.addSubview(logo)
        logo.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
            make.height.width.equalTo(76 * kScale)
        }
        logo.superview?.layoutIfNeeded()
        logo.layer.cornerRadius = logo.frame.size.width / 2
        
        self.view.addSubview(titles)
        titles.snp.makeConstraints { (make) in
            make.top.equalTo(logo.snp.bottom).offset(15 * kScaleY)
            make.centerX.equalToSuperview()
            make.width.equalTo(100 * kScale)
            make.height.equalTo(50 * kScaleY)
        }
        let title = UILabel()
        title.text = "SECTOR"
        let subTitle = UILabel()
        subTitle.text = "news"
        titles.addSubview(title)
        titles.addSubview(subTitle)
        title.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(29 * kScaleY)
        }
        subTitle.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(21)
        }
        title.font = UIFont.customFont(customType: .Montserrat, ofSize: 24 * kScale)
        title.textColor = UIColor(red: 0.18, green: 0.18, blue: 0.18,alpha:1)
        title.numberOfLines = 0
        
        subTitle.textAlignment = .center
        subTitle.font = UIFont.customFont(customType: .Avenir, ofSize: 16 * kScale)
        
        // 输入框
        let username = RoundTextFiled(placeholder: "Email", isPass: false)
        
        let password = RoundTextFiled(placeholder: "Password", isPass: true)
        
        self.view.addSubview(username)
        self.view.addSubview(password)
        username.snp.makeConstraints { (make) in
            make.top.equalTo(titles.snp.bottom).offset(49 * kScaleY)
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
        
        // 登陆、注册按钮
        let signIn = RoundUIButton(title: "Sign in", borderWidth: nil, textColor: .white)
        let signUp = RoundUIButton(title: "Sign up", borderWidth: nil, textColor: .white)
        
        let signView = UIView()
        self.view.addSubview(signView)
        signView.snp.makeConstraints { (make) in
            make.top.equalTo(password.snp.bottom).offset(15 * kScaleY)
            // make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(40 * kScale)
            make.right.equalToSuperview().offset(-40 * kScale)
            make.height.equalTo(40 * kScaleY)
        }
        signView.addSubview(signIn)
        signView.addSubview(signUp)
        signUp.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            // make.width.equalTo(signView.snp.width).dividedBy(2).offset(7) //  / 2 - 15 * kScale
            make.left.equalToSuperview()
            make.right.equalTo(signView.snp.right).dividedBy(2).offset(-7.5 * kScale)
        }
        signUp.backgroundColor = .black
        signIn.backgroundColor = UIColor(red: 0.16, green: 0.4, blue: 1, alpha: 1)
        
        signIn.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            // make.width.equalTo(signView.snp.width).dividedBy(2).offset(7) //  / 2 - 15 * kScale
            make.left.equalTo(signUp.snp.right).offset(15 * kScale)
            make.right.equalToSuperview()
        }
        
        self.view.addSubview(forgetPassword)
        forgetPassword.snp.makeConstraints { (make) in
            make.top.equalTo(signView.snp.bottom).offset(20 * kScaleY)
            make.centerX.equalToSuperview()
            make.height.equalTo(22 * kScaleY)
        }
        
        // 最底部signUp按钮
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        addSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc private func toSignup(_ sender: UIButton) {
        self.navigationController?.pushViewController(LoginUpViewController(), animated: true)
    }
    
}
