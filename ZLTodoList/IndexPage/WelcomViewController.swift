//
//  WelcomViewController.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/13.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit
import SwiftyJSON

class WelcomViewController: UIViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(customType: .Montserrat, ofSize: 24)
        label.textAlignment = .center
        label.text = "Features"
        return label
    }()
    
    private lazy var subTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.customFont(customType: .Avenir, ofSize: 16)
        label.textAlignment = .center
        label.text = "The best of news channels all in one place. Trusted sources and personalized news for you."
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Get started", for: .normal)
        btn.backgroundColor = UIColor(red: 0.16, green: 0.4, blue: 1, alpha: 1)
        btn.layer.cornerRadius = 6
        btn.layer.masksToBounds = true
        btn.titleLabel?.textColor = .white
        btn.titleLabel?.textAlignment = .center
        return btn
    }()
    
    private func addSubviews() {
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60 * kScaleY)
        }
        self.view.addSubview(subTitle)
        subTitle.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(kScreenW / 375 * 242)
            make.top.equalTo(titleLabel.snp.bottom).offset(14 * kScaleY)
        }
        
        let cat1 = IndexCategory(image: "index1", text: "Compelling photography and typography provide a beautiful reading")
        self.view.addSubview(cat1)
        cat1.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(80 * kScaleY)
            make.top.equalTo(subTitle.snp.bottom).offset(86 * kScaleY)
        }
        cat1.layoutChildView()
        
        
        let cat2 = IndexCategory(image: "index2", text: "Sector news never shares your personal data with advertisers or publishers")
        self.view.addSubview(cat2)
        cat2.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(80 * kScaleY)
            make.top.equalTo(cat1.snp.bottom).offset(40 * kScaleY)
        }
        cat2.layoutChildView()
        
        let cat3 = IndexCategory(image: "index3", text: "You can get Premium to unlock hundreds of publications")
        self.view.addSubview(cat3)
        cat3.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(80 * kScaleY)
            make.top.equalTo(cat2.snp.bottom).offset(40 * kScaleY)
        }
        cat3.layoutChildView()
        
        self.view.addSubview(startButton)
        startButton.snp.makeConstraints { (make) in
            make.top.equalTo(cat3.snp.bottom).offset(80 * kScaleY)
            make.left.equalToSuperview().offset(40 * kScale)
            make.right.equalToSuperview().offset(-40 * kScale)
            make.height.equalTo(44 * kScaleY)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.view.backgroundColor = .red
        // self.navigationController?.pushViewController(LoginViewController(), animated: true)
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        addSubviews()
//        let dic = ["name": 123]
//
//        HttpDatas.sharedInstance.requstDatas(.get, URLString: "http://120.27.69.15:3000/getCategory", paramasters: dic) { (response) in
//
//            let jsonData = JSON(response)
//
//            print("jsonData = \(jsonData)")
//        }
        
    }
}
