//
//  PeopleViewModel.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/11.
//  Copyright © 2020 张杰. All rights reserved.
//

import Foundation
import RxSwift

struct PeopleListModel {
    let data = Observable.just([
        People(name: "张三", age: 14),
        People(name: "李四", age: 24),
        People(name: "王武", age: 34),
        People(name: "赵六", age: 44),
    ])
}
