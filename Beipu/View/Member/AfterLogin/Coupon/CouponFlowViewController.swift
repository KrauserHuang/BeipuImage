//
//  CouponFlowViewController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/8/5.
//

import UIKit

class CouponFlowViewController: UIViewController {

    var initFlag = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true
        self.view.backgroundColor = .clear
        self.view.isOpaque = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if initFlag {
            showView()
            initFlag = false
        }else{
            dismiss(animated: false)
        }
    }
    
    func showView(){
        RootWindow?.loadingAction()
        guard let user = UserService.shared.user else{return}
        let url = API_URL + URL_MYCOUPONLIST
        let parameters: [String:Any] = ["member_id":user.member_id, "member_pwd":user.member_pwd]
        WebAPI.shared.request(urlStr: url, parameters: parameters) { isSuccess, data, error in
            RootWindow?.finishLoading()
            guard isSuccess, let data = data, let results = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else{return}
            var canuseList = [Coupon]()
            var usedList = [Coupon]()
            var outOfDateList = [Coupon]()
            for result in results {
                let coupon = Coupon(from: result)
                switch coupon.checkAvailable() {
                case .Available:
                    canuseList.append(coupon)
                case .OutDate:
                    outOfDateList.append(coupon)
                case .Used:
                    usedList.append(coupon)
                default:
                    break
                }
            }
            let tabBarController = OnTopTabBarController()
            let canUseController = UIStoryboard(name: "CouponTableViewController", bundle: nil).instantiateViewController(withIdentifier: "CouponTableViewController") as! CouponTableViewController
            canUseController.tabBarItem = UITabBarItem(title: "可兌換", image: nil, tag: 0)
            canUseController.delegate = self
            canUseController.couponList = canuseList
            let usedController = UIStoryboard(name: "CouponTableViewController", bundle: nil).instantiateViewController(withIdentifier: "CouponTableViewController") as! CouponTableViewController
            usedController.tabBarItem = UITabBarItem(title: "已兌換", image: nil, tag: 0)
            usedController.couponList = usedList
            let outOfDateController = UIStoryboard(name: "CouponTableViewController", bundle: nil).instantiateViewController(withIdentifier: "CouponTableViewController") as! CouponTableViewController
            outOfDateController.tabBarItem = UITabBarItem(title: "已過期", image: nil, tag: 0)
            outOfDateController.couponList = outOfDateList
            tabBarController.edgesForExtendedLayout = []
            tabBarController.setNavigationTitle("優惠券")
            tabBarController.viewControllers = [canUseController, usedController, outOfDateController]
            self.pushViewController(tabBarController, animated: true)
            #if DEBUG
            usedController.delegate = self
            outOfDateController.delegate = self
            #endif
        }
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
}

extension CouponFlowViewController: CouponTableViewControllerDelegate {
    func selectAction(_ viewController: CouponTableViewController, coupon: Coupon) {
        let controller = CouponCodeViewController()
        controller.setNavigationTitle("優惠券")
        controller.coupon = coupon
        pushViewController(controller, animated: true)
    }
}
