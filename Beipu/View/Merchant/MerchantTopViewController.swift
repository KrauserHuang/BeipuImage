//
//  MerchantTopViewController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/8/4.
//

import UIKit
protocol MerchantTopViewControllerDelegate: AnyObject {
    func logoutAction(_ viewController: MerchantTopViewController)
}

class MerchantTopViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var qrCodeView: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBAction func qrCodeAction(_ sender: Any) {
        let controller = MerchantScanViewController()
        controller.delegate = self
        pushViewController(controller, animated: true)
    }
    @IBAction func logoutAction(_ sender: Any) {
        UserService.shared.logout()
        delegate?.logoutAction(self)
    }
    
    weak var delegate: MerchantTopViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = UserService.shared.user?.member_name
        
        let t = Theme()
        t.setThemeLayer(logoutButton)
        t.setThemeLayer(qrCodeView)
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
}

extension MerchantTopViewController: MerchantScanViewControllerDelegate {
    func dismissSelf(_ viewController: MerchantScanViewController) {
        navigationController?.popViewController(animated: true)
    }
    func gotContent(_ viewController: MerchantScanViewController, content: String) {
        print("content:\(content)")
        let content = "beipu://?" + content
        let components = URLComponents(string: content)
//        guard let id = components?.searchValue(for: "m_id"), let no = components?.searchValue(for: "coupon_no"), let user = UserService.shared.user else{
        guard let no = components?.searchValue(for: "coupon_no"), let user = UserService.shared.user else{
            viewController.captureSession?.startRunning()
            return}
        let alert = UIAlertController.simpleOKAlert(title: "", message: "是否核銷此商品券", buttonTitle: "確定核銷", canCancel: true) { _ in
            let url = API_URL + URL_APPLYCOUPON
//            let parameter = "member_id=\(user.member_id)&member_pwd=\(user.member_pwd)&m_id=\(id)&coupon_no=\(no)"
            let parameter = "member_id=\(user.member_id)&member_pwd=\(user.member_pwd)&coupon_no=\(no)"
            WebAPI.shared.request(urlString: url, parameters: parameter) { isSuccess, data, error in
                if isSuccess {
                    let alert = UIAlertController.simpleOKAlert(title: "", message: "已核銷", buttonTitle: "確認") { _ in
                        viewController.captureSession?.startRunning()
                    }
                    DispatchQueue.main.async {
                        viewController.present(alert, animated: true, completion: nil)
                    }
                }else{
                    var message = "核銷錯誤"
                    if let data = data, let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let responseMessage = result["responseMessage"] as? String {
                        message = responseMessage
                    }
                    let alert = UIAlertController.simpleOKAlert(title: "", message: message, buttonTitle: "確認") { _ in
                        viewController.captureSession?.startRunning()
                    }
                    DispatchQueue.main.async {
                        viewController.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
