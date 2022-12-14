//
//  CouponTableViewController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/7/4.
//

import UIKit
protocol CouponTableViewControllerDelegate: AnyObject {
    func selectAction(_ viewController: CouponTableViewController, coupon: Coupon)
}

class CouponTableViewController: UITableViewController {

    weak var delegate: CouponTableViewControllerDelegate?
    var couponList = [Coupon]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        將畫面下拉補足tabbar標籤的空缺
//        let delta =  view.bounds.maxY
        view.frame.origin = CGPoint(x: 0, y: 44)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return couponList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CouponTableViewCell", for: indexPath) as! CouponTableViewCell
        cell.coupon = couponList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        delegate?.selectAction(self, coupon: couponList[indexPath.row])
    }
    
}

class CouponTableViewCell: UITableViewCell {
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var limitLabel: UILabel!
    
    var coupon: Coupon? {
        didSet{
            setCouponView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        borderView.layer.shadowOpacity = 0.5
        borderView.layer.shadowOffset = .init(width: 1, height: 1)
        borderView.layer.cornerRadius = 5
        setCouponView()
    }
    
    func setCouponView(){
        descriptLabel?.text = coupon?.coupon_description
        limitLabel?.text = "兌換期限：" + (coupon?.coupon_enddate ?? "無")
    }
    
}
