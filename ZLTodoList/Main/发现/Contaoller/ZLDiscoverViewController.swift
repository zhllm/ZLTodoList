//
//  ZLDiscoverViewController.swift
//  ZLTodoList
//
//  Created by 张杰 on 2020/6/14.
//  Copyright © 2020 张杰. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ZLDiscoverViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var tableView: UITableView!
    
    weak var refreshButton: UIBarButtonItem!
    
    weak var addButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: self.view.frame, style: .plain)
        self.view.addSubview(tableView)
        // self.navigationController?.navigationBar.tintColor = .black
        configNav()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let initVM = TableViewModel()
        refreshButton = self.tabBarController!.navigationItem.leftBarButtonItem!
        addButton = self.tabBarController!.navigationItem.rightBarButtonItem!
        
        let refreshCommand = refreshButton.rx.tap.asObservable()
            .startWith(()).flatMap(getRandomResult).map(TableEditingCommand.setItems)
        
        let addCommand = addButton.rx.tap.asObservable()
            .map { "\(arc4random())" }.map(TableEditingCommand.additem)
        
        let movedCommand = tableView.rx.itemMoved.map(TableEditingCommand.moveitem)
        
        let deleteCommand = tableView.rx.itemDeleted.asObservable()
            .map(TableEditingCommand.deleteItem)
        
        Observable.of(refreshCommand, addCommand, movedCommand, deleteCommand)
            .merge()
            .scan(initVM) { (vm: TableViewModel, command: TableEditingCommand) ->
                TableViewModel in
                return vm.execute(command: command)
        }
        .startWith(initVM)
        .map {
            [AnimatableSectionModel(model: "", items: $0.items)]
        }
        .share(replay: 1, scope: .whileConnected)
        .bind(to: tableView.rx.items(dataSource: ZLDiscoverViewController.dataSource()))
        .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.setEditing(true, animated: animated)
    }
    
    func getRandomResult() -> Observable<[String]> {
        print("生成随机数据")
        let items = (0 ..< 5).map { _ in
            "\(arc4random())"
        }
        return Observable.just(items)
    }
    
    /// 配置导航栏
    func configNav() {
        let navItem = self.tabBarController?.navigationItem
        let button = UIBarButtonItem(title: "刷新", style: .plain, target: self, action: #selector(refresh))
        navItem?.setLeftBarButton(button, animated: true)
        navItem?.title = "TodoList"
        let img = UIImage(named: "icons-facebook")
        let rightButton = UIBarButtonItem(image: img, landscapeImagePhone: img, style: .plain, target: self, action: #selector(add))
        navItem?.setRightBarButton(rightButton, animated: true)
    }
    
    @objc func refresh() {
        print("refresh")
    }
    
    @objc func add() {
        print("add")
    }

}


extension ZLDiscoverViewController{
    static func dataSource() -> RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String, String>> {
        return RxTableViewSectionedAnimatedDataSource(animationConfiguration: AnimationConfiguration(insertAnimation: .top, reloadAnimation: .fade, deleteAnimation: .left), configureCell: { (dataSource, tv, indexPath, element) -> UITableViewCell in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "条目\(indexPath.row)：\(element)"
            return cell
        }, canEditRowAtIndexPath: { (_, _) -> Bool in
            return true
        }, canMoveRowAtIndexPath: { (_, _) -> Bool in
            return true
        })
    }
}
