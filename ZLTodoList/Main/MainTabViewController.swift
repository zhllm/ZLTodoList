//
//  MainTabViewController.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/13.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    var indexFlag = 0
    // ZLWXViewController
    private func addControllers(){
        
        self.addChildControllers(ZLDiscoverViewController(), title: "发现", image: "icons-twitter", selectImg: "icons-twitter")
        // ZLWXViewController ZLWXMainViewController
        self.addChildControllers(ZLContactViewController(), title: "通讯录", image: "icons-google", selectImg: "icons-google")
        self.addChildControllers(ZLWXMainViewController(), title: "微信", image: "icons-facebook", selectImg: "icons-facebook")
        
        self.addChildControllers(ZLMineViewController(), title: "我", image: "icons-facebook", selectImg: "icons-facebook")
        self.addChildControllers(ZLMineViewController(), title: "我", image: "icons-facebook", selectImg: "icons-facebook")
    }
    
    // icons-facebook icons-google  icons-twitter channel-bbc
    private func addChildControllers(_ childVC: UIViewController, title: String, image: String, selectImg: String){
        // item 文字
        childVC.tabBarItem.title = title
        // 未选中图片 withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        childVC.tabBarItem.image = UIImage(named: image) // .withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : RGBColor(r: 245, g: 98, b: 93)], for: .selected)
        // 头部导航
        
        self.addChild(childVC)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // indexFlag
        if let index = tabBar.items?.firstIndex(of: item) {
            if indexFlag != index {
                animationWithIndex(index: index)
            }
        }
    }
    
    private func animationWithIndex(index: Int) {
        var arrViews = [UIView]()
        
        for tabbarButton in tabBar.subviews {
            if tabbarButton .isKind(of: NSClassFromString("UITabBarButton")!) {
                arrViews.append(tabbarButton)
            }
        }
        let pluse = CABasicAnimation(keyPath: "transform.scale")
        pluse.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pluse.duration = 0.1
        pluse.repeatCount = 1
        pluse.autoreverses = true
        pluse.fromValue = NSNumber(value: 0.7)
        pluse.toValue = NSNumber(value: 1.1)
        arrViews[index].layer.add(pluse, forKey: nil)
        indexFlag = index
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addControllers()

        //        for (index, value) in UIFont.familyNames.enumerated() {
        //            print("\(index) : --- \(value) \n")
        //            // Avenir Montserrat iconfont
        //        }
    }
    
}
