//
//  TableEditingActions.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/7/9.
//  Copyright © 2020 张杰. All rights reserved.
//
import UIKit

enum TableEditingCommand {
    case setItems(items: [String])
    case additem(item: String)
    case moveitem(from: IndexPath, to: IndexPath)
    case deleteItem(IndexPath)
}
