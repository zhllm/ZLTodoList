//
//  ViewController.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/9.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit
import SnapKit

class ViewController1: UIViewController {
    
    var userName: RoundTextFiled!
    var password: RoundTextFiled!
    var loginButton: RoundUIButton!
    var textView: UILabel!
    
    override func viewDidLoad() {
        userName = RoundTextFiled(placeholder: "请输入您的用户名", isPass: false)
        password = RoundTextFiled(placeholder: "请输入您的密码", isPass: true)
        loginButton = RoundUIButton(title: "登陆")
        
        self.view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeInput))
        self.view.addGestureRecognizer(tapGesture)
        textView = UILabel()
        textView.text = "null"
        
        textView.text = "Hello Swift, This is a Label Study Lession"
        
        // 设置字体大小
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        // label.font = UIFont.systemFont(ofSize: 20.0)
        
        // 设置字体颜色 （红色）
        textView.textColor = UIColor.red
        
        // 设置背景色
        textView.backgroundColor = UIColor.gray
        
        // 设置文字对齐方式 （left , center , right）
        textView.textAlignment = NSTextAlignment.center
        
        // 设置阴影
        textView.shadowOffset = CGSize(width: 2, height: 3) // 阴影的偏移量
        textView.shadowColor = UIColor.orange
        
        // 设置label 的显示行数 0 为无限行
        textView.numberOfLines = 0
        
        self.view.addSubview(userName)
        self.view.addSubview(password)
        self.view.addSubview(loginButton)
        self.view.addSubview(textView)
        
        userName.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60.0)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        password.snp.makeConstraints { (make) in
            make.top.equalTo(userName.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(userName.snp.width)
            make.height.equalTo(userName.snp.height)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(password.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(userName.snp.width)
            make.height.equalTo(userName.snp.height)
        }
        
        textView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-100)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        loginButton.addTarget(self, action: #selector(submit), for: UIControl.Event.touchUpInside)
        
        
        
    }
    
    @objc func submit(_ sender: UIButton) {
        print(userName.text ?? "")
        textView.text = userName.text
    }
    
    @objc func closeInput() {
        print("--------")
        userName.resignFirstResponder()
    }
}

