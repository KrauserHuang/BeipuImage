//
//  OnTopTabBarController.swift
//
//  Created by 陳昱宏 on 2021/1/12.
//

import UIKit

//在上方顯示頁籤的TabBarController
class OnTopTabBarController: UITabBarController {
//    var didLayoutFlag = true
//    var willLayoutFlag = true
    override var viewControllers: [UIViewController]? {
        didSet{
            guard viewControllers != nil else {return}
//            設定分頁標籤
//            setSelectionIndicator()
            setTabBarItemText()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        設定tabbar位置
        self.tabBar.frame = CGRect(x: 0, y: view.frame.origin.y, width: tabBar.frame.size.width, height: tabBar.frame.size.height)
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.backgroundColor = UIColor.clear
        let layer = Theme().getThemeLayer(size: self.tabBar.frame.size)
        self.tabBar.backgroundImage = UIImage.layerImage(from: layer).tinted(with: .white)
        
    }
    
    func setSelectionIndicator(){
//        設定選擇指示圖(底線)
        let indicatorWidth = tabBar.frame.width / CGFloat(tabBar.items!.count)
        self.tabBar.selectionIndicatorImage = createSelectionIndicator(color: Theme.redColor, size: CGSize(width: indicatorWidth, height: tabBar.frame.height), lineWidth: 1)
    }
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
//        製作選擇指示圖
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 15, y: size.height - 10, width: size.width - 30, height: lineWidth))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func setTabBarItemText(){
//        設定標籤文字
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .lightGray
        for item in self.tabBar.items! {
            item.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Arial", size: 16)!], for: [])
            item.titlePositionAdjustment.vertical = -10
        }
    }

}
