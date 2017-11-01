//
//  ProfileViewController.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

// 可重用标识符
private let kTableViewCellIdentifier = "kTableViewCellIdentifier"

class ProfileViewController: UIViewController {
    
    // MARK: - 懒加载属性
    
    
    /// tableView
    fileprivate lazy var tableView: UITableView = {
        
        // 创建tableView
        let tableView = UITableView(frame: self.view.bounds, style: .grouped)
        
        // 调整tableView默认的组间距
        tableView.sectionHeaderHeight = 5
        tableView.sectionFooterHeight = 0
        
        // 设置tableView岁父控件一起拉伸
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 设置数据源代理
        tableView.dataSource = self
        
        // 注册cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kTableViewCellIdentifier)
        
        return tableView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // 统一设置UI界面
        setupUI()
    }

}



// MARK: - 设置UI界面
extension ProfileViewController {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置导航栏
        setupNavigationBar()
        
        // 添加tableView
        view.addSubview(tableView)
        
        tableView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 10, right: 0)
        
    }
    
    /// 设置导航栏
    private func setupNavigationBar() {
        
        // 添加导航条左边的按钮
        setupLeftBarButtonItem()
        
        // 添加导航条右边的按钮
        setupRightBarButtonItems()
    }
    
    /// 添加导航条左边的按钮
    private func setupLeftBarButtonItem() {
        
        // 自定义左边的按钮
        let leftBtn = UIButton()
        leftBtn.setImage(UIImage(named: "myMessage_30x30_"), for: .normal)
        leftBtn.setImage(UIImage(named: "myMessagepress_30x30_"), for: .highlighted)
        leftBtn.sizeToFit()
        leftBtn.addTarget(self, action: #selector(leftBarButtonItemClick), for: .touchUpInside)  // 监听按钮的点击
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
    }
    
    
    /// 添加导航条右边的按钮
    private func setupRightBarButtonItems() {
        
        // 自定义左边的按钮
        let rightBtn = UIButton()
        rightBtn.setImage(UIImage(named: "searchInNavigation_30x30_"), for: .normal)
        rightBtn.setImage(UIImage(named: "searchInNavigationpress_30x30_"), for: .highlighted)
        rightBtn.sizeToFit()
        rightBtn.addTarget(self, action: #selector(rightBarButtonItemClick), for: .touchUpInside)  // 监听按钮的点击
        
        // 调整导航栏左边按钮与屏幕的距离
        let rightItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        rightItem.width = -5
        navigationItem.rightBarButtonItems = [rightItem,UIBarButtonItem(customView: rightBtn)]
    }
}





// MAR: - 监听导航栏上面按钮的点击
extension ProfileViewController {
    
    /// 监听导航条leftBarButtonItem的点击
    @objc fileprivate func leftBarButtonItemClick() {
        
        print("ProfileViewController---leftBarButtonItemClick")
    }
    
    /// 监听导航条试听历史按钮点击
    @objc fileprivate func rightBarButtonItemClick() {
        
        print("ProfileViewController---rightBarButtonItemClick")
    }
}




// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    
    //
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: kTableViewCellIdentifier)
        
        cell?.textLabel?.text = "cell---\(indexPath.row)"
        
        return cell!
    }
    
}

