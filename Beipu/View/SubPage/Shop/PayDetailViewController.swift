//
//  PayDetailViewController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/7/25.
//

import UIKit
protocol PayDetailViewControllerDelegate: AnyObject {
    func payAction(_ viewController: PayDetailViewController)
}

class PayDetailViewController: UIViewController {
    @IBOutlet weak var shipmentTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var paymentTextField: UITextField!
    @IBOutlet weak var couponTextField: UITextField!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var shipFeeLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!
    @IBAction func payAction(_ sender: Any) {
        delegate?.payAction(self)
    }
    
    weak var delegate: PayDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
}
