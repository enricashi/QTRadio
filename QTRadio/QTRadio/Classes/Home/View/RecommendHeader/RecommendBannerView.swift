//
//  RecommendBannerView.swift
//  QTRadio
//
//  Created by Enrica on 2017/11/11.
//  Copyright © 2017年 Enrica. All rights reserved.
//
// 推荐界面的无线轮播器(或者说banner)

import UIKit


/// collectionViewCell标识符
private let kBannerCellIdentifier = "kBannerCellIdentifier"

/// recommendIndicator的高度
private let kRecommendIndicatorHeight: CGFloat = 3

class RecommendBannerView: UIView {
    
    
    // MARK: - 定时器属性
    
    fileprivate var bannerTimer: Timer?
    
    
    // MARK: - 模型属性
    
    // 用于接收从控制器传递过来的模型数据
    var bannerModelArray: [BannerModel]? {
        
        didSet {
            
            // 监听bannerModelArray的改变
            // 然后刷新表格，重新载入数据
            recommendBannerView.reloadData()
            
            // 校验数组bannerModelArray是否有值
            guard let bannerModelArray = bannerModelArray else { return }
            
            // 取出行模型的个数
            for typeItem in bannerModelArray {
                for titleItem in typeItem.bannerDataModelArray {
                    guard let count = titleItem.data?.count else { return }
                    
                    // 保存itemCount
                    itemCount = count
                }
            }
            
            // 设置recommendIndicator的frame
            recommendIndicator.frame = CGRect(x: 0, y: bannerViewHeight - kRecommendIndicatorHeight, width: kScreenWidth / CGFloat(itemCount), height: kRecommendIndicatorHeight)
            
            // 创建一个比较大的indexPath
            let indexPath = IndexPath(item: itemCount * 100, section: 0)
            
            // 让recommendBannerView滚动到这个indexPath，从而可以往左边无限滚动
            recommendBannerView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            // MARK: - 当模型中有数据时，我们就添加定时器
            
            // 在添加定时器之前，先移除定时器
            // 然后再添加定时器
            removeBannerTimer()
            addBannerTimer()
        }
    }
    
    
    
    
    
    // MARK: - 私有属性
    
    /// bannerViewHeight
    fileprivate var bannerViewHeight: CGFloat
    
    /// 保存行模型的个数
    fileprivate var itemCount: Int = 0
    

    // MARK: - 控件属性
    
    /// collectionView控件
    fileprivate lazy var recommendBannerView: UICollectionView = {
        
        // 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenWidth, height: bannerViewHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal

        // 创建collectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: bannerViewHeight), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        // 设置数据源代理，并注册cell
        collectionView.dataSource = self
        collectionView.register(RecommendBannerViewCell.self, forCellWithReuseIdentifier: kBannerCellIdentifier)
        
        // 设置代理
        collectionView.delegate = self
        
        return collectionView
    }()
    
    /// pageControl控件
    fileprivate lazy var recommendIndicator: UIView = {
        let recommendIndicator = UIView()
        recommendIndicator.backgroundColor = UIColor(r: 214, g: 51, b: 52)
        return recommendIndicator
    }()
    
    
    fileprivate lazy var pageControl: RecommendPageControl = {
        
        let pageControl = RecommendPageControl(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 25))
        return pageControl
    }()
    
    
    
    // MARK: - 自定义构造函数
    override init(frame: CGRect) {
        
        // 初始化私有属性
        self.bannerViewHeight = frame.size.height
        
        super.init(frame: frame)
        
        // 统一设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





// MARK: - 设置UI界面
extension RecommendBannerView {
    
    /// 统一设置UI界面
    fileprivate func setupUI() {
        
        // 添加collectionView
        addSubview(recommendBannerView)
        
        // 添加pageControl
        addSubview(pageControl)
        
        // 添加recommendIndicator
        //addSubview(recommendIndicator)
        
    }
    
    // 重新布局子控件的位置
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 重新布局recommendIndicator的尺寸
        
        
        // 重新布局pageControl的位置
        pageControl.snp.makeConstraints { (make) in
            make.height.equalTo(4)
            make.left.equalTo(self)
            make.bottom.equalTo(self)
            make.right.equalTo(self)
        }
    }
}



// MARK: - UICollectionViewDataSource
extension RecommendBannerView: UICollectionViewDataSource {
    
    // 返回cell的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // 接着取出组模型
        let typeItem = bannerModelArray?[section]
        
        // 然后取出title模型
        let titleItem = typeItem?.bannerDataModelArray.first
        
        // 接着取出标题模型数组中存放数据的数组data，其中data的个数即为cell的个数
        let count = titleItem?.data?.count
        
        // 让它的真实数量乘以一个很大的数，可以让它有充分的滚动控件
        return (count ?? 6) * 10000
    }
    
    // 返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kBannerCellIdentifier, for: indexPath) as! RecommendBannerViewCell
        
        // 首先校验数组bannerModelArray是否有值
        guard let bannerModelArray = bannerModelArray else { return cell }
        
        // 接着取出分组模型
        let typeItem = bannerModelArray[indexPath.section]
        
        // 然后取出标题模型
        guard let titleItem = typeItem.bannerDataModelArray.first else { return cell }
        
        // 最后取出行模型(因为上面乘以了一个很大的数，为了不越界，这里indexPath.item需要模上行模型的个数)
        let dataItem = titleItem.bannerDataDataModelArray[indexPath.item % titleItem.data!.count]
        
        // 设置数据
//        cell.cellImageView.kf.setImage(with: URL(string: dataItem.imgUrl))
        cell.cellImageView.setImage(dataItem.imgUrl)
        
        return cell
    }
    
}



// MARK: - UICollectionViewDelegate
extension RecommendBannerView: UICollectionViewDelegate {
    
    // 监听Banner的滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 获取当前的偏移量
        let currentOffsetX = scrollView.contentOffset.x
        
        // 计算pageControl当前的
        pageControl.currentPage = Int(currentOffsetX / scrollView.bounds.width) % itemCount
        
    }
    
    // 监听用户拖动手势，一旦用户手动拖拽bannerView，要将定时器移除
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        // 移除定时器
        removeBannerTimer()
    }
    
    // 用户结束拖拽bannerView，再次添加定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        // 添加定时器
        addBannerTimer()
    }
    
    // 点击Banner上面的图片，跳转到对应的控制器
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 取出tabBarVc
        guard let tabBarVc: UITabBarController = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController else { return }
        
        // 取出当前选中的导航控制器
        let nav: UINavigationController = (tabBarVc.selectedViewController as? UINavigationController)!
        
        // 创建控制器
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.randomColor()
        
        // 通过当前选中的导航控制器push到下一个控制器
        nav.pushViewController(vc, animated: true)
        
    }
}





// MARK: - 定时器相关的操作方法
extension RecommendBannerView {
    
    /// 添加定时器
    fileprivate func addBannerTimer() {
        
        // 创建定时器
        bannerTimer = Timer(timeInterval: 2.0, target: self, selector: #selector(RecommendBannerView.scrollToFuture), userInfo: nil, repeats: true)
        
        // 将定时器添加到运行循环中
        RunLoop.main.add(bannerTimer!, forMode: .commonModes)
    }
    
    
    /// 移除定时器
    fileprivate func removeBannerTimer() {
        
        // 将定时器从运行循环中移除
        bannerTimer?.invalidate()
        
        // 将bannerTimer清空
        bannerTimer = nil
    }
    
    /// 执行滚动的方法
    @objc fileprivate func scrollToFuture() {
        
        // 获取当前的偏移量
        let currentOffsetX = recommendBannerView.contentOffset.x
        
        // 计算需要滚动的偏移量(即滚动一个bannerView的宽度即可)
        let offsetX = currentOffsetX + recommendBannerView.bounds.width
        
        // 滚动到下一个位置
        recommendBannerView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
