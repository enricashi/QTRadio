//
//  UIImage-Extension.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/2.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// UIImage的扩展，用来返回特定的图片

import UIKit

extension UIImage {
    
    /// 返回一张受保护的拉伸图片
    /// - 参数imageName：表示图片的名称
    /// - returns：最终会返回一张按照设定保护区域进行拉伸的图片
    class func imageWithStretchalbe(_ imageName: String) -> UIImage {
        
        // 加载原始图片
        let originalImage = UIImage(named: imageName)
        
        // 获取原始图片的size
        let imageSize = originalImage!.size
        
        // 对原始图片进行拉伸并返回
        return originalImage!.resizableImage(withCapInsets: UIEdgeInsets(top: imageSize.height * 0.5, left: imageSize.width * 0.5, bottom: imageSize.height * 0.5 - 1, right: imageSize.width * 0.5 - 1))
    }
    
    
    /// 快速返回一张没有经过渲染的图片
    /// - 参数imageName：表示图片的名称
    /// - returns：返回一张没有经过编译器渲染的原始图片
    class func imageWithOriginal(_ imageName: String) -> UIImage {
        
        // 加载原始图片
        let originalImage = UIImage(named: imageName)
        
        // 返回不经过渲染的图片
        return originalImage!.withRenderingMode(.alwaysOriginal)
    }
}
