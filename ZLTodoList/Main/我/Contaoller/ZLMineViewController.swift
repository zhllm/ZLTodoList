//
//  ZTMineViewController.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/14.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

class ZLMineViewController: UIViewController {
    
    var styles: UIStatusBarStyle = .default
    var loginViewOriginY:CGFloat!
    let minDragDis: CGFloat = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.styles
    }
    
    private lazy var button: UIButton = {
        let btn = UIButton.init(type: .roundedRect)
        btn.frame = CGRect(x: 10, y: 300, width: kScreenW - 20, height: 40)
        btn.backgroundColor = .green
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var loginView: LoginView = {
        let logv = LoginView.loadFromNib()
        // LoginView.init(frame: CGRect(x: 0, y: kScreenH, width: kScreenW, height: kScreenH))
        logv.frame = CGRect(x: 0, y: kScreenH, width: kScreenW, height: kScreenH)
        // logv.backgroundColor = .white
        logv.layer.cornerRadius = 10
        logv.layer.masksToBounds = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan(gesture:)))
        
        logv.addGestureRecognizer(panGesture)
        return logv
    }()
    
    private lazy var grayView: UIView = {
        let grayv = UIView(frame: self.view.bounds)
        grayv.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        grayv.alpha = 0
        return grayv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        loginViewOriginY = kStatusBarH //  + 50
        self.view.addSubview(self.button)
        self.view.addSubview(self.grayView)
        self.view.addSubview(self.loginView)
    }
    
    
    @objc private func downMove() {
        UIView.animate(withDuration: 0.2){
            self.loginView.frame = CGRect(
                x: 0,
                y: self.loginViewOriginY,
                width: kScreenW,
                height: kScreenH)
            self.grayView.alpha = 1
        }
    }
    
    private func createHidden(value: NSInteger) {
        if value == 1 {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.tabBarController?.tabBar.isHidden = true
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            self.perform(#selector(hidTabBar), with: nil, afterDelay: 0.25)
        }
    }
    
    @objc func hidTabBar() {
        self.tabBarController?.tabBar.isHidden = false
    }
    
}

/// 拖拽事件监听
extension ZLMineViewController{
    @objc private func pan(gesture: UIPanGestureRecognizer){
        if gesture.state == .began {
            print("开始拖动了")
        } else if gesture.state == .changed {
            // gesture 是在整个拖拽过程一直存在的状态
            // 这里y表示，从开始拖拽到此刻，已相对view在y轴上移动的距离
            let y = gesture.translation(in: self.view).y
            if y <= minDragDis {
                self.loginView.frame = CGRect(x: 0, y: loginViewOriginY, width: kScreenW, height: kScreenH)
            } else {
                self.loginView.frame = CGRect(
                    x: 0,
                    y: loginViewOriginY + y,
                    width: kScreenW,
                    height: kScreenH)
            }
            
            var scollAlpha = self.loginView.frame.origin.y / kScreenH / 2
            if scollAlpha > 0.5 {
                scollAlpha = 0.5
            }
            
            self.grayView.alpha = 1 - scollAlpha
        } else if gesture.state == .ended {
            if self.loginView.frame.origin.y <= kScreenH / 2 {
                UIView.animate(withDuration: 0.25){
                    self.loginView.frame = CGRect(
                        x: 0,
                        y: self.loginViewOriginY,
                        width: kScreenW,
                        height: kScreenH)
                    self.grayView.alpha = 1
                }
            } else {
                UIView.animate(withDuration: 0.25){
                    self.loginView.frame = CGRect(
                        x: 0,
                        y: kScreenH,
                        width: kScreenW,
                        height: kScreenH)
                    self.grayView.alpha = 0.0
                }
            }
            
            if self.grayView.alpha >= 0.5 {
                self.styles = .lightContent
                setNeedsStatusBarAppearanceUpdate()
            } else {
                self.styles = .default
                setNeedsStatusBarAppearanceUpdate()
                UIView.animate(withDuration: 0.25) {
                    self.createHidden(value: 0)
                }
            }
        }
    }
    
    
}

/// 注册页弹出按钮监听
extension ZLMineViewController{
    @objc private func btnClick(_ sender: UIButton) {
        createHidden(value: 1)
        
        // 文字白色
        self.styles = .lightContent
        // 刷新状态栏
        setNeedsStatusBarAppearanceUpdate()
        
        // 开始一个持续0.5秒的动画
        UIView.animate(withDuration: 0.5){
            // 动画内容 1. 改变loginView 的 frame，让loginView y 处于状态栏一半的高度
            self.loginView.frame = CGRect(
                x: 0,
                y: self.loginViewOriginY / 2,
                width: kScreenW,
                height: kScreenH)
            // 将grayView 的alpha为1，展示一个灰色蒙层
            self.grayView.alpha = 1
        }
        
        /// 上一步将loginView y 处于状态栏一半的高度，这一步将loginView 的y坐标在0.5秒后变为状态的高度
        self.perform(#selector(downMove), with: nil, afterDelay: 0.5)
    }
}
