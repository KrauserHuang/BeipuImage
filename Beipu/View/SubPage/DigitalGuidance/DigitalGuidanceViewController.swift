//
//  DigitalGuidanceViewController.swift
//  Beipu
//
//  Created by Tai Chin Huang on 2022/9/1.
//

import UIKit

protocol DigitalGuidanceViewControllerDelegate: AnyObject {
    func nextAction(_ viewController: DigitalGuidanceViewController, index: Int)
}

class DigitalGuidanceViewController: UIViewController {
    
    @IBOutlet var mapButtons: [UIButton]!
    @IBOutlet var mapImageButtons: [UIButton]!
    @IBOutlet weak var imageView: UIImageView!
    
    weak var delegate: DigitalGuidanceViewControllerDelegate?
    let mapList = [
        "",
        "北埔慈天宮",
        "姜阿新洋樓",
        "金廣福公館",
        "姜氏家廟",
        "叮咚橋",
        "秀巒公園",
        "忠恕堂",
        "鄧南光影像紀念館",
        "天水堂"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.addCornerRadius(8)

        for button in mapButtons {
            let index = button.tag
            button.setImage(UIImage.init(systemName: "\(index).circle"), for: .normal)
            button.setTitle(mapList[index], for: .normal)
        }
    }
    @IBAction func nextAction(_ sender: UIButton) {
        delegate?.nextAction(self, index: sender.tag)
    }
}
