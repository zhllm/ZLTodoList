//
//  TableViewModel.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/7/9.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit

struct TableViewModel {
    var items: [String]
    
    init(items: [String] = []) {
        self.items = items
    }
    
    func execute(command: TableEditingCommand) -> TableViewModel {
        switch command {
        case .setItems(let items):
            print("设置表格数据")
            return TableViewModel(items: items)
        case .additem(let item):
            print("添加新的数据\(item)")
            var items = self.items
            items.append(item)
            return TableViewModel(items: items)
        case .moveitem(let from, let to):
            print("移动")
            var items = self.items
            items.insert(items.remove(at: from.row), at: to.row)
            return TableViewModel(items: items)
        case .deleteItem(let path):
            print("删除表格数据")
            var items = self.items
            items.remove(at: path.row)
            return TableViewModel(items: items)
        }
    }
}
