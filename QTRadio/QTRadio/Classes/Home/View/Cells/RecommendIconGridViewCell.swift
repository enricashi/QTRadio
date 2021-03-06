//
//  RecommendIconGridViewCell.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/12.
//  Copyright © 2017年 Enrica. All rights reserved.
//

import UIKit


/// 间距
private let kMargin: CGFloat = 8

/// imageView的宽度
private let kImageViewWidth: CGFloat = 42

class RecommendIconGridViewCell: UICollectionViewCell {
    
    // MARK: - 懒加载属性
    
    /// 按钮
    lazy var cellImageView: UIImageView = {
        
        let cellImageView = UIImageView()
        cellImageView.image = UIImage(named: "gridIcon_placeholder_42x42_")
        
        return cellImageView
    }()
    
    /// 标题
    lazy var cellTitleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "必听榜单"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// MARK: - 设置UI界面
extension RecommendIconGridViewCell {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 设置cell的背景颜色
        backgroundColor = .white
        
        // 删除contentView中所有的子控件
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // 添加图片
        contentView.addSubview(cellImageView)
        
        // 添加标题
        contentView.addSubview(cellTitleLabel)
    }
    
    /// 重新布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 布局cellImageView的位置
        cellImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(kMargin)
            make.centerX.equalTo(self)
            make.width.equalTo(kImageViewWidth)
            make.height.equalTo(kImageViewWidth)
        }
        
        
        // 布局cellTitleLabel的位置
        cellTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-kMargin)
        }
    }
    
    
    /// 清除之前的数据
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellTitleLabel.text = nil
        cellImageView.image = UIImage(named: "gridIcon_placeholder_42x42_")
    }
}
