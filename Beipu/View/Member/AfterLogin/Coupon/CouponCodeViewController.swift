//
//  CouponCodeViewController.swift
//
//  Created by 陳Mike on 2021/6/11.
//

import UIKit

protocol CouponCodeViewControllerDelegate: AnyObject {
    func back(_ viewController: CouponCodeViewController)
}

class CouponCodeViewController: UIViewController {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var qrImage: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var timeLimitLabel: UILabel!
    
    weak var delegate: CouponCodeViewControllerDelegate?
    var coupon: Coupon?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        navigationItem.hidesBackButton = true
//        let backbtn = UIBarButtonItem(image: UIImage(named: "icon_back"), style: .plain, target: self, action: #selector(goback))
//        navigationItem.leftBarButtonItems = [backbtn]
        setCoupon()
    }
    @objc func goback(){
        delegate?.back(self)
    }
    func setCoupon(){
        guard let coupon = coupon else{return}
//        if coupon.coupon_type == "3" {
//            title = "入會禮"
//        }else if coupon.coupon_type == "6" {
//            title = "註冊禮"
//        }else if coupon.coupon_type == "7" {
//            title = "AR好禮"
//        }
//        itemImage.image = coupon.coupon_picture
        timeLimitLabel.text = "\(coupon.coupon_startdate)～\(coupon.coupon_enddate)"
        itemNameLabel.text = "憑本券可兌換\(coupon.coupon_name)"
        descriptLabel.text = coupon.coupon_description
        let userId = UserService.shared.user!.member_id
//        let string = "m_id=\(userId)&coupon_no=\(coupon.coupon_no)"
        let string = "coupon_no=\(coupon.coupon_no)"
        setQRCode(str: string)
    }
//    產生QRCode
    func setQRCode(str: String) {
        let data = str.data(using: .isoLatin1, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
//        設定錯誤修正等級LMQH
        filter?.setValue("L", forKey: "inputCorrectionLevel")
//        產生QRCode圖片
        guard let qrcodeImage = filter?.outputImage else {return}
        let scale = qrImage.frame.width / qrcodeImage.extent.width
//        將產生的QRCode放大
        let newImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
        qrImage.image = UIImage(ciImage: newImage)
    }
}
