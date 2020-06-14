//
//  PeopleViewController.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/11.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa



class PeopleViewController: UIViewController {
    
    var mytable: UITableView!
    
    let disposeBag = DisposeBag()
    let peopleList = PeopleListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mytable = UITableView(frame: self.view.bounds)
        self.view.addSubview(mytable)
        
        mytable.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        
        peopleList.data
            .bind(to: mytable.rx.items(cellIdentifier: "myCell")) {_, model, cell in
                cell.textLabel?.text = model.name
                cell.detailTextLabel?.text = String(model.age)
        }.disposed(by: disposeBag)
        
        mytable.rx.modelSelected(People.self).subscribe(onNext: { people in
            print("选择了\(people)")
            }).disposed(by: disposeBag)
        
        mytable.rx.itemSelected.subscribe(onNext: { indexPath in
            print("当前选中了\(indexPath.row)")
            }).disposed(by: disposeBag)
    }
    
}
