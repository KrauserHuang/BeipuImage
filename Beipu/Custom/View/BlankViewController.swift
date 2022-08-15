//
//  BlankViewController.swift
//
//  Created by 陳Mike on 2021/7/2.
//

import UIKit
//只有一行文字的空白頁
class BlankViewController: UIViewController {
    @IBOutlet weak var messageLabel: UILabel!

    var message = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setMessage(str: message)
    }
    
    func setMessage(str: String) {
        messageLabel.text = str
    }
}
