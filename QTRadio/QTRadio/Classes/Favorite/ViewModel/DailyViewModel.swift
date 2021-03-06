//
//  DailyViewModel.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/5.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


/// 请求地址
private let kRequestURL = "http://rec.c.qingting.fm/v1/recommend/daily"

/// deviceid
private let kDeviceid = "093e8b7e24c02246fe92373727e4a92c"

class DailyViewModel: NSObject {

    lazy var dailyArr: [DailyModel] = [DailyModel]()
}


extension DailyViewModel {
    
    /// 请求今日推荐模块中主控制器的网络数据
    func requestData(completionHandler: @escaping () -> ()) {
        
        NetworkTools.shareTools.requestData(kRequestURL, .get, parameters: ["deviceid": kDeviceid, "nocache": "\(NSDate.getCurrentTime())"]) { (result) in
            
            // 将JSON数据转成字典
            guard let resultDict = result as? [String: Any] else { return }
            
            // 根据键data取出字典resultDict中的数据，然后再将其转成成字典数组(即，数组中存放的是字典)
            guard let resultArr = resultDict["data"] as? [[String: Any]] else { return }
            
            // 遍历数组resultArr中的字典数据，然后再将其转为模型
            for dict in resultArr {
                
                // 将字典传入模型AlbumModel进行转换
                let daily = DailyModel(dict: dict)
                
                // 将转换完成的模型存入数组
                self.dailyArr.append(daily)
            }
            
            // 模型转换完成以后，需要将其回调出去
            completionHandler()
        }
    }
}
