//
//  collectionViewModel.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/8/10.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

class CollectionViewModel: NSObject {
    var name: String
    var picture: String
    
    init(name: String, picture: String) {
        self.name = name
        self.picture = picture
    }
}


