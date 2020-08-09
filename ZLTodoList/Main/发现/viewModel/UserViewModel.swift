//
//  UserViewModel.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/7/27.
//  Copyright © 2020 张杰. All rights reserved.
//

import RxSwift
import RxRelay

struct UserViewModel {
    let username = BehaviorRelay(value: "guest")
    
    lazy var userInfo = {
        return self.username.map{ $0 == "hangge" ? "您是管理员" : "您是普通访客" }
            .share(replay: 1, scope: .whileConnected)
    }()
}
