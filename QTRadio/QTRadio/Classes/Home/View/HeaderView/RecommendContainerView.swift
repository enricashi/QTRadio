//
//  RecommendContainerView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/12.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit

/// bannerView的高度
private let kBannerViewHeight: CGFloat = 145

/// iconGridHeight:
private let kIconGridHeight: CGFloat = 145

/// 间距
private let kMargin: CGFloat = 5



class RecommendContainerView: UIView {
    
    // MARK: - 私有属性
    fileprivate var containerHeight: CGFloat

    // MARK: - 懒加载控件
    
    /// 顶部的Banner
    fileprivate lazy var bannerView: RecommendBannerView = {
        
        let bannerView = RecommendBannerView.recommendBannerView()
        bannerView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kBannerViewHeight)
        return bannerView
    }()
    
    /// 中间的IconGrid
    fileprivate lazy var iconGridView: RecommentIconGridView = {
        
        let iconGridView = RecommentIconGridView(frame: CGRect(x: 0, y: kBannerViewHeight, width: kScreenWidth, height: kIconGridHeight))
        return iconGridView
    }()
    
    /// 底部的HotWordGrid
    fileprivate lazy var hotWordGridView: RecommendHotWordGridView = {
        
        let hotWordGridView = RecommendHotWordGridView(frame: CGRect(x: 0, y: kBannerViewHeight + kIconGridHeight + kMargin, width: kScreenWidth, height: containerHeight - kBannerViewHeight - kIconGridHeight - 2 * kMargin))
        
        
        return hotWordGridView
    }()
    
    
    // MARK: - 自定义构造函数
    override init(frame: CGRect) {
        
        // 初始化私有属性
        self.containerHeight = frame.size.height
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




// MARK: - 设置UI界面
extension RecommendContainerView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置背景颜色
        backgroundColor = UIColor(r: 245, g: 244, b: 249)
        
        // 添加bannerView
        addSubview(bannerView)
        
        // 添加iconGridView
        addSubview(iconGridView)
        
        // 添加hotWordGridView
        addSubview(hotWordGridView)
    }
}
