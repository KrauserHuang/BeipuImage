//
//  NaviGetPointViewController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/7/24.
//

import UIKit
protocol NaviGetPointViewControllerDelegate: AnyObject {
    func backAction(_ viewController: NaviGetPointViewController)
}

class NaviGetPointViewController: UIViewController {
    @IBOutlet weak var descriptLabel: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: NaviGetPointViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setView()
    }
    
    func setView(){
        
    }
    

    @IBAction func backBtnClicked(_ sender: UIButton) {
        delegate?.backAction(self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
