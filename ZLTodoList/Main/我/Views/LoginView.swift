//
//  LoginView.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/14.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

class LoginView: UIView {
    /// 账号注册的标题
    @IBOutlet weak var topTitle: UILabel!
    
    /// 电话号码输入容器View
    @IBOutlet weak var phoneView: UIView!
    
    /// 电话输入框
    @IBOutlet weak var phoneField: UITextField!
    
    /// 验证码输入容器
    @IBOutlet weak var codeView: UIView!
    
    /// 验证码输入框
    @IBOutlet weak var codeTextFiled: UITextField!
    
    /// 注册按钮
    @IBOutlet weak var registerButton: UIButton!
    
    /// 登陆类型容器
    @IBOutlet weak var loginTypeView: UIView!
    
    /// 查看协议
    @IBOutlet weak var lookDeail: UIView!
    
    /// 已同意协议内容
    @IBOutlet weak var lookedDetail: UIView!
    
    override func layoutSubviews() {
        setUI()
    }
    
}

/// 设置属性
extension LoginView{
    
    private func setUI(){
        self.lookedDetail.isHidden = true
        self.loginTypeView.isHidden = true
        
        self.phoneView.layer.borderWidth = 1;
        self.phoneView.layer.borderColor = UIColor.gray.cgColor
        self.phoneView.layer.cornerRadius = customLayer(num: 22.5)
        self.phoneView.layer.masksToBounds = true
        
        self.codeView.layer.borderWidth = 1;
        self.codeView.layer.borderColor = UIColor.gray.cgColor
        self.codeView.layer.cornerRadius = customLayer(num: 22.5)
        self.codeView.layer.masksToBounds = true
        
        self.registerButton.layer.cornerRadius = customLayer(num: 22.5)
        self.registerButton.layer.masksToBounds = true
    }
    
}

/// 加载当前view的Xnib
extension LoginView {
    class func loadFromNib() -> LoginView {
        return Bundle.main.loadNibNamed("LoginView", owner: nil, options: nil)?[0] as! LoginView
    }
}
