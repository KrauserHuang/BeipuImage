//
//  EMapViewController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/8/4.
//

import UIKit
protocol EMapViewControllerDelegate: AnyObject {
    func nextAction(_ viewController: EMapViewController, index: Int)
}

class EMapViewController: UIViewController {
    @IBOutlet var mapButtons: [UIButton]!
    @IBAction func nextAction(_ sender: UIButton) {
        delegate?.nextAction(self, index: sender.tag)
    }
    
    weak var delegate: EMapViewControllerDelegate?
    let mapList = ["","北埔第一棧","福美軒飲食店","登富茶坊客家菜","姜太公柿餅","北埔擂茶堂","山水屋民宿",
                   "清香麵店","北埔廟前粄條","璞鈺擂茶","哈客愛擂茶","大豐收庭苑餐館","新竹北埔林",
                   "秀汶水","茶米二十二","泥磚屋小吃店","噹好吃鹹豬肉","陳記鹹豬肉","阿麵製麵廠",
                   "佐京茶陶","隆源餅行","鄒記菜包","阿滿水晶餃","陳媽媽黃金包","彭家粄糕",
                   "民歌擂茶","深山裡柴燒蘿蔔糕","北埔食堂","上品擂茶客家菜","榕樹下粄條","劉家小館"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        for button in mapButtons {
            let index = button.tag
            button.setImage(UIImage.init(systemName: "\(index).circle"), for: .normal)
            button.setTitle(mapList[index], for: .normal)
        }
    }
}
