//
//  NaviCategoryViewController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/7/6.
//

import UIKit


class NaviCategoryViewController: UIViewController {
    @IBOutlet var riddleButtons: [UIButton]!
    @IBOutlet weak var getCouponButton: UIButton!
    @IBAction func naviAction(_ sender: UIButton) {
//        let controller = UIStoryboard(name: "NaviStoreListCollectionViewController", bundle: nil).instantiateViewController(withIdentifier: "NaviStoreListCollectionViewController") as! NaviStoreListCollectionViewController
//        controller.setNavigationTitle("數位導覽")
//        controller.delegate = self
//        setNavigationButton(controller)
//        pushViewController(controller, animated: true)
        
        let controller = NaviDescriptViewController()
        controller.setNavigationTitle("數位導覽")
        controller.questNo = sender.tag
        arIndex = sender.tag
        controller.delegate = self
        setNavigationButton(controller)
        pushViewController(controller, animated: true)
    }
    @IBAction func getCouponButtonTapped(_ sender: UIButton) {
        //新的API(URL_GETCOUPON3)
        let url = API_URL + URL_GETCOUPON3
        let user = UserService.shared.user
        let parameters: [String: String] = [
            "member_id":user?.member_id ?? "",
            "member_pwd":user?.member_pwd ?? "",
//                        "coupon_id":coupon_id
        ]
        WebAPI.shared.request(urlStr: url, parameters: parameters) { isSuccess, data, error in
            if let data = data {
                print(String(data: data, encoding: .utf8))
            }
        }
        Alert.showMessage(title: "AR優惠券", msg: "已成功領取", vc: self) {
            self.couponAction()
            self.getCouponButton.isUserInteractionEnabled = false
            self.getCouponButton.backgroundColor = .systemGray4
            self.getCouponButton.setTitle("領取小禮物(已領取)", for: .normal)
        }
        return
    }
    
    enum FinishState {
        case yes, no
    }
    @MainActor
    var state = FinishState.no {
        didSet {
            riddleButtons[arIndex - 1].backgroundColor = state == .yes ? .systemGray4 : .themeRed
            riddleButtons[arIndex - 1].setTitle(state == .yes ? "謎題\(arIndex)(已完成)" : "謎題\(arIndex)", for: .normal)
//            riddleButtons[arIndex - 1].titleLabel?.text = state == .yes ? "謎題\(arIndex)(已完成)" : "謎題\(arIndex)"
            riddleButtons[arIndex - 1].isUserInteractionEnabled = state == .no
            
//            getCouponButton.backgroundColor = state == .yes ? .systemGray4 : .themeRed
            if riddleButtons.allSatisfy({ button in
                button.isUserInteractionEnabled == false
            }) {
                getCouponButton.isHidden = false
            } else {
                getCouponButton.isHidden = true
            }
        }
    }

    var arIndex = 0
    let coupon_id = "ARCOUPON3"
    let arKey = "gotArSpot"
    var gotAr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigationButton(self)
        
        getCouponButton.isHidden = true
        
    }
    
    func setNavigationButton(_ viewController: UIViewController){
        let couponBtn = UIBarButtonItem(image: UIImage(named: "coupon")?.imageResized(to: CGSize(width: 35, height: 35)), style: .plain, target: self, action: #selector(couponAction))
        couponBtn.tintColor = .black
        viewController.navigationItem.rightBarButtonItem = couponBtn
    }
    @objc func couponAction(){
        let controller = CouponFlowViewController()
        controller.setNavigationTitle(title ?? "")
        let navi = UINavigationController(rootViewController: controller)
        navi.modalPresentationStyle = .overFullScreen
        present(navi, animated: false)
    }
    
    func setArSpot(){
        if let str =  UserDefaults.standard.string(forKey: arKey) {
            let temp = str.split(separator: ",")
            for c in temp {
                gotAr.append("\(c)")
            }
        }
        #if DEBUG
        UserDefaults.standard.removeObject(forKey: arKey)
        #endif
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
}

//extension NaviCategoryViewController: NaviStoreListCollectionViewControllerDelegate {
//    func itemAction(_ viewController: NaviStoreListCollectionViewController) {
//        let controller = BeiPuSpotViewController()
//        controller.modalPresentationStyle = .fullScreen
//        present(controller, animated: true)
//    }
//}

extension NaviCategoryViewController: NaviDescriptViewControllerDelegate {
    func nextAction(_ viewController: NaviDescriptViewController) {
        let controller = NaviCameraViewController()
        controller.setNavigationTitle("數位導覽")
        controller.delegate = self
        controller.arIndex = arIndex
        pushViewController(controller, animated: true)
    }
}

extension NaviCategoryViewController: NaviCameraViewControllerDelegate {
    func getAction(_ viewController: NaviCameraViewController, arIndex: Int, distance: Double) {
        var controller: UIViewController
        var area: ((Double, Double)->Bool)
//        #if DEBUG
//        area = { $0 > $1 }
//        #else
        area = { $0 < $1 }
//        #endif
        if area(distance, 50) {
            if !gotAr.contains("\(arIndex)") {
                gotAr.append("\(arIndex)")
                print(#function)
                print("gotAr:\(gotAr)")
                state = .yes
                let str = gotAr.joined(separator: ",")
                UserDefaults.standard.set(str, forKey: "gotArSpotBeipu")
//                if gotAr.count == 5 {
//                    //舊的API(URL_GETCOUPON2)
////                    let url = API_URL + URL_GETCOUPON2
////                    let user = UserService.shared.user
////                    let parameters: [String: String] = ["member_id":user?.member_id ?? "", "member_pwd":user?.member_pwd ?? "", "coupon_id":coupon_id]
////                    WebAPI.shared.request(urlStr: url, parameters: parameters) { isSuccess, data, error in
////                        if let data = data {
////                            print(String(data: data, encoding: .utf8))
////                        }
////                    }
////                    couponAction()
////                    return
//                    //新的API(URL_GETCOUPON3)
//                    let url = API_URL + URL_GETCOUPON3
//                    let user = UserService.shared.user
//                    let parameters: [String: String] = [
//                        "member_id":user?.member_id ?? "",
//                        "member_pwd":user?.member_pwd ?? "",
////                        "coupon_id":coupon_id
//                    ]
//                    WebAPI.shared.request(urlStr: url, parameters: parameters) { isSuccess, data, error in
//                        if let data = data {
//                            print(String(data: data, encoding: .utf8))
//                        }
//                    }
//                    couponAction()
//                    return
//                }
            }
            controller = NaviGetPointViewController()
            (controller as? NaviGetPointViewController)?.delegate = self
        }else{
            controller = NaviNotInRangeViewController()
            (controller as? NaviNotInRangeViewController)?.delegate = self
        }
        controller.setNavigationTitle("數位導覽")
        pushViewController(controller, animated: true)
    }
}

extension NaviCategoryViewController: NaviNotInRangeViewControllerDelegate {
    func backAction(_ viewController: NaviNotInRangeViewController) {
        navigationController?.popViewController(animated: true)
    }
}

extension NaviCategoryViewController: NaviGetPointViewControllerDelegate {
    func backAction(_ viewController: NaviGetPointViewController) {
        navigationController?.popToViewController(self, animated: true)
    }
}
