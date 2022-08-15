//
//  PayRecordDetailViewController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/8/3.
//

import UIKit

class PayRecordDetailViewController: UIViewController {
    @IBOutlet weak var payNoLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var payMoneyLabel: UILabel!
    @IBOutlet weak var payMethodLabel: UILabel!
    @IBOutlet weak var orderStatusLabel: UILabel!
    @IBOutlet weak var payStatusLabel: UILabel!
    @IBOutlet weak var shippingLabel: UILabel!
    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var itemTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var itemsPriceLabel: UILabel!
    @IBOutlet weak var shippingFeeLabel: UILabel!
    @IBOutlet weak var couponLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    

    var orderNo = ""
    var record: PayRecord? {
        didSet{
            setRecordView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchRecord()
    }
    
    func fetchRecord(){
        guard let user = UserService.shared.user else{return}
        let url = API_URL + URL_ORDERINFO
        let parameters: [String:Any] = ["member_id":user.member_id, "member_pwd":user.member_pwd, "order_no":orderNo]
        WebAPI.shared.request(urlStr: url, parameters: parameters) { isSuccess, data, error in
            guard isSuccess, let data = data, let results = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]], let result = results.first else{return}
            self.record = .init(from: result)
        }
    }
    
    func setRecordView(){
        guard let record = record else{return}
        payNoLabel.text = record.order_no
//        timeLabel.text = record.order_updated_at
        payMoneyLabel.text = record.order_pay
        payMethodLabel.text = record.pay_type
        
        
        
    }
    
    
    
}

class PayRecordDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quentyLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
}
