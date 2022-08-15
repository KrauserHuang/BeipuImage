//
//  ItemDetailViewController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/7/22.
//

import UIKit
protocol ItemDetailViewControllerDelegate: AnyObject {
    func addtoCartAction(_ viewController: ItemDetailViewController)
    func buyNowAction(_ viewController: ItemDetailViewController)
}

class ItemDetailViewController: UIViewController {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var quentyTextField: UITextField!
    @IBOutlet var maskedCornersButtons: [UIButton]!
    
    @IBAction func quentyAction(_ sender: UIButton) {
        quenty += sender.tag
    }
    @IBAction func shoppingAction(_ sender: UIButton) {
        if sender.tag > 0 {
            delegate?.addtoCartAction(self)
        }else{
            delegate?.buyNowAction(self)
        }
    }
    
    weak var delegate: ItemDetailViewControllerDelegate?
    var quenty = 1 {
        didSet{
            if quenty < 1 {
                quenty = 1
            }else{
                quentyTextField.text = "\(quenty)"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setCornerView()
    }
    
    func setCornerView(){
        for button in maskedCornersButtons {
            button.layer.cornerRadius = button.bounds.height / 2
            if button.tag > 0 {
                button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            }else{
                button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            }
        }
    }
    
}
