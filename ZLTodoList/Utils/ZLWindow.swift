//
//  ZLWindow.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/14.
//  Copyright © 2020 张杰. All rights reserved.
//

import Foundation
import UIKit
/// 屏幕宽高
let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height
let kScale = kScreenW / 375
let kScaleY = kScreenH / (812 - 44 - 34)

/// keyWindow
let keyWindow = UIApplication.shared.connectedScenes
    .filter({$0.activationState == .foregroundActive})
    .map({$0 as? UIWindowScene})
    .compactMap({$0})
    .first?.windows
    .filter({$0.isKeyWindow}).first

/// 判断是不是手机
let kIsIphone = Bool(UIDevice().userInterfaceIdiom == UIUserInterfaceIdiom.phone)

/// 判断是不是iphoneX
let kIsIphoneX = Bool(kScreenW >= 375.0 && kScreenH >= 812.0 && kIsIphone)

/// 导航条高度
let kNavgationBarH = CGFloat(kIsIphoneX ? 88 : 64)

/// 状态栏高度
let kStatusBarH = CGFloat(kIsIphoneX ? 44 : 20)

/// tabbar 高度
let kTabBarH = CGFloat(kIsIphoneX ? (49 + 24) : 49)

/// 自定义颜色
func RGBColor(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    return UIColor.init(red: r / 255.0, green:  g / 255.0, blue:  b / 255.0, alpha: 1)
}

/// 字号
func customFont(font: CGFloat) -> UIFont {
    /// 刘海屏
    guard kScreenH < 736 else {
        return UIFont.systemFont(ofSize: font)
    }
    
    /// 5.5英寸
    guard kScreenH == 736 else {
        return UIFont.systemFont(ofSize: font - 2)
    }
    
    /// 4.7 英寸
    guard kScreenH >= 736 else {
        return UIFont.systemFont(ofSize: font - 4)
    }
    
    return UIFont.systemFont(ofSize: font)
}

func customLayer(num: CGFloat) -> CGFloat {
    /// 大于736
    guard kScreenH <= 736 else {
        return num * 1.3
    }
    
    /// 小于736
    guard kScreenH == 736 else {
        return num * 1.1
    }
    
    guard kScreenH >= 736 else {
        return num
    }
    
    return num * 1.2
}


