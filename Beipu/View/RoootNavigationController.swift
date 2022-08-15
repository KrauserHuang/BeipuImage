//
//  RoootNavigationController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/6/24.
//

import UIKit

class RoootNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller = UIStoryboard(name: "TopPageViewController", bundle: nil).instantiateViewController(identifier: "TopPageViewController") as! TopPageViewController
        controller.delegate = self
        controller.setNavigationTitle("北埔印象")
        self.viewControllers = [controller]
        
//        let cartBtn = UIBarButtonItem(image: UIImage(named: "cart")?.imageResized(to: CGSize(width: 35, height: 35)), style: .plain, target: self, action: #selector(cartAction))
//        cartBtn.tintColor = .black
        let memberBtn = UIBarButtonItem(image: UIImage(named: "member")?.imageResized(to: CGSize(width: 35, height: 35)), style: .plain, target: self, action: #selector(memberAction))
        memberBtn.tintColor = .black
        controller.navigationItem.rightBarButtonItems = [memberBtn]
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            let layer = Theme().getThemeLayer(size: CGSize(width: UIScreen.main.bounds.width, height: 100))
            let image = UIImage.layerImage(from: layer)
            appearance.backgroundImage = image
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }else{
            let layer = Theme().getThemeLayer(size: CGSize(width: UIScreen.main.bounds.width, height: 100))
            let image = UIImage.layerImage(from: layer)
            navigationBar.setBackgroundImage(image, for: .default)
            navigationBar.shadowImage = UIImage()
        }
        
        if UserService.shared.didLogIn {
            loginMerchant(animated: false)
        }else{
            UserService.shared.renewUser = {
                self.loginMerchant(animated: false)
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        防止有bug沒有正常登入店長介面
        if UserService.shared.user?.member_type == 2 {
            loginMerchant(animated: true)
        }
    }
    
    func loginMerchant(animated: Bool){
        guard UserService.shared.user?.member_type == 2 else{return}
        let controller = MerchantTopViewController()
        controller.setNavigationTitle("北埔店長")
        controller.delegate = self
        let navi = UINavigationController(rootViewController: controller)
        navi.modalPresentationStyle = .fullScreen
        self.present(navi, animated: animated)
    }
    
    @objc func cartAction(){
        
    }
    @objc func memberAction(){
        let user = UserService.shared.user
        if user == nil {
            let controller = LogInFlowViewController()
            controller.setNavigationTitle("北埔印象")
            controller.delegate = self
            let navi = UINavigationController(rootViewController: controller)
            navi.modalPresentationStyle = .overFullScreen
            present(navi, animated: false)
        }else{
            let controller = MemberCenterFlowViewController()
            controller.setNavigationTitle("北埔印象")
            controller.delegate = self
            let navi = UINavigationController(rootViewController: controller)
            navi.modalPresentationStyle = .overFullScreen
            present(navi, animated: false)
        }
    }
}

extension RoootNavigationController: TopPageViewControllerDelegate {
    func planAction(_ viewController: TopPageViewController) {
        let controller = BlankViewController()
        controller.message = "Coming soon......"
        pushViewController(controller, animated: true)
        controller.setNavigationTitle("主題套餐")
        
//        let tabBarController = OnTopTabBarController()
//        tabBarController.edgesForExtendedLayout = []
//        let day1controller = UIStoryboard(name: "BeipuSetTableViewController", bundle: nil).instantiateViewController(withIdentifier: "BeipuSetTableViewController") as! BeipuSetTableViewController
//        day1controller.tabBarItem = .init(title: "北埔遊程Day 1", image: nil, tag: 0)
//        day1controller.delegate = self
//        let day2controller = UIStoryboard(name: "BeipuSetTableViewController", bundle: nil).instantiateViewController(withIdentifier: "BeipuSetTableViewController") as! BeipuSetTableViewController
//        day2controller.tabBarItem = .init(title: "北埔遊程Day 2", image: nil, tag: 1)
//        day2controller.delegate = self
//        tabBarController.viewControllers = [day1controller, day2controller]
//        tabBarController.setNavigationTitle("主題套餐")
//        pushViewController(tabBarController, animated: true)
    }
    
    func mapAction(_ viewController: TopPageViewController) {
        let controller = EMapViewController()
        controller.setNavigationTitle("電子地圖")
        controller.delegate = self
        pushViewController(controller, animated: true)
    }
    
    func naviAction(_ viewController: TopPageViewController) {
        let controller = NaviCategoryViewController()
        controller.setNavigationTitle("數位導覽")
        
        pushViewController(controller, animated: true)
    }
    
    func healthAction(_ viewController: TopPageViewController) {
        if let url = URL(string: "healthmanage://"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }else if let url = URL(string: "https://apps.apple.com/tw/app/id1610454916"){
            UIApplication.shared.open(url)
        }
    }
    
    func parkingAction(_ viewController: TopPageViewController) {
        let controller = ParkingViewController()
        controller.setNavigationTitle("停車資訊")
        pushViewController(controller, animated: true)
    }
    
    func shopAction(_ viewController: TopPageViewController) {
        let controller = BlankViewController()
        controller.message = "Coming soon......"
        pushViewController(controller, animated: true)
        controller.setNavigationTitle("線上商城")
        
//        let tabBarController = OnTopTabBarController()
//        tabBarController.edgesForExtendedLayout = []
//        tabBarController.setNavigationTitle("線上商城")
//        let tabArray = ["全部","機能飲品"]
//        for i in 0..<tabArray.count {
//            let controller = UIStoryboard(name: "ItemListCollectionViewController", bundle: nil).instantiateViewController(withIdentifier: "ItemListCollectionViewController") as! ItemListCollectionViewController
//            controller.tabBarItem = .init(title: tabArray[i], image: nil, tag: i)
//            controller.delegate = self
//            if i == 0 {
//                tabBarController.viewControllers = [controller]
//            }else{
//                tabBarController.viewControllers?.append(controller)
//            }
//        }
//        pushViewController(tabBarController, animated: true)
    }
}

extension RoootNavigationController: LogInFlowViewControllerDelegate {
    func loginAction(_ viewController: LogInFlowViewController) {
        if UserService.shared.user?.member_type == 2 {
            dismiss(animated: false) {
                self.loginMerchant(animated: true)
            }
        }else{
            let controller = MemberCenterFlowViewController()
            controller.setNavigationTitle("北埔印象")
            controller.delegate = self
            let navi = UINavigationController(rootViewController: controller)
            navi.modalPresentationStyle = .overFullScreen
            dismiss(animated: false) {
                self.present(navi, animated: false)
            }
        }
    }
}
extension RoootNavigationController: MemberCenterFlowViewControllerDelegate {
    func logoutAction(_ viewController: MemberCenterFlowViewController) {
        let controller = LogInFlowViewController()
        controller.setNavigationTitle("北埔印象")
        controller.delegate = self
        let navi = UINavigationController(rootViewController: controller)
        navi.modalPresentationStyle = .overFullScreen
        dismiss(animated: false) {
            self.present(navi, animated: false)
        }
    }
}

extension RoootNavigationController: ItemListCollectionViewControllerDelegate {
    func detailAction(_ viewController: ItemListCollectionViewController) {
        let controller = ItemDetailViewController()
        controller.setNavigationTitle("線上商城")
        controller.delegate = self
        pushViewController(controller, animated: true)
    }
}

extension RoootNavigationController: BeipuSetTableViewControllerDelegate {
    func detailAction(_ viewController: BeipuSetTableViewController) {
        let controller = BlankViewController()
        controller.message = "Coming soon......"
        controller.setNavigationTitle("主題套餐")
        pushViewController(controller, animated: true)
    }
}

extension RoootNavigationController: ItemDetailViewControllerDelegate {
    func addtoCartAction(_ viewController: ItemDetailViewController) {
        
    }
    
    func buyNowAction(_ viewController: ItemDetailViewController) {
        addtoCartAction(viewController)
        let controller = UIStoryboard(name: "ShoppingCartTableViewController", bundle: nil).instantiateViewController(withIdentifier: "ShoppingCartTableViewController") as! ShoppingCartTableViewController
        controller.setNavigationTitle("購物車")
        controller.delegate = self
        pushViewController(controller, animated: true)
    }
}

extension RoootNavigationController: ShoppingCartTableViewControllerDelegate {
    func nextAction(_ viewController: ShoppingCartTableViewController) {
        let controller = PayDetailViewController()
        controller.setNavigationTitle("購物車")
        controller.delegate = self
        pushViewController(controller, animated: true)
    }
}

extension RoootNavigationController: PayDetailViewControllerDelegate {
    func payAction(_ viewController: PayDetailViewController) {
        let controller = PayResultViewController()
        controller.setNavigationTitle("")
        controller.isFailed = Int.random(in: 0...1) == 0
        pushViewController(controller, animated: true)
    }
}

extension RoootNavigationController: EMapViewControllerDelegate {
    func nextAction(_ viewController: EMapViewController, index: Int) {
        let controller = EMapDetailViewController()
        controller.setNavigationTitle("電子地圖")
        controller.index = index
        pushViewController(controller, animated: true)
    }
}

extension RoootNavigationController: MerchantTopViewControllerDelegate {
    func logoutAction(_ viewController: MerchantTopViewController) {
        dismiss(animated: true)
    }
}
