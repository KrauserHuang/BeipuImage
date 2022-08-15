//
//  NaviNotInRangeViewController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/7/24.
//

import UIKit
protocol NaviNotInRangeViewControllerDelegate: AnyObject {
    func backAction(_ viewController: NaviNotInRangeViewController)
}

class NaviNotInRangeViewController: UIViewController {
    @IBOutlet weak var descriptText: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: NaviNotInRangeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setAreaView()
    }
    func setAreaView(){
        
    }
    

    @IBAction func backBtnClicked(_ sender: UIButton) {
        delegate?.backAction(self)
    }
    
}
