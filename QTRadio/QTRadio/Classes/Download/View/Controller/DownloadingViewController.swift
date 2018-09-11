//
//  DownloadingViewController.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/1.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 主要是用来管理下载模块中正在下载界面

import UIKit

class DownloadingViewController: UIViewController {
    
    
    override func loadView() {
        super.loadView()
        
        // 创建downloadView
        let downloadView = DownloadView(frame: self.view.bounds)
        
        // 设置downloadView为当前控制器的view
        self.view = downloadView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

