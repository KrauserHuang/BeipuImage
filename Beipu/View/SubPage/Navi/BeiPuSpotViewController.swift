//
//  BeiPuSpotViewController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/7/7.
//
import UIKit

protocol BeiPuSpotViewControllerDelegate: AnyObject {
    func spotAction(_ viewController: BeiPuSpotViewController)
}

class BeiPuSpotViewController: UIViewController {
    @IBOutlet weak var spotImageView: UIImageView!
    @IBOutlet weak var spotDescriptLabel: UILabel!
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func spotAction(_ sender: Any) {
//        guard let arinfo = arinfo else{return}
//        delegate?.arAction(self, arInfo: arinfo)
    }
    
//    var arinfo: ARInfo?
//    var arShopInfos = [ARShopInfo]()
    weak var delegate: BeiPuSpotViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setARView()
    }
    
    func setARView(){
//        if let image = arinfo?.ar_picture {
//            self.arImageView.image = image
//        }else{
//            arinfo?.renewImage = {
//                self.arImageView.image = self.arinfo?.ar_picture
//            }
//        }
//        arDescriptLabel.text = arinfo?.ar_descript
    }
    
}
