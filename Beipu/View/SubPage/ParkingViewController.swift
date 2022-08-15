//
//  ParkingViewController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/7/5.
//

import UIKit

class ParkingViewController: UIViewController {
    @IBOutlet var parkButtons: [UIButton]!
    @IBOutlet weak var parkNameLabel: UILabel!
    @IBOutlet weak var spaceLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBAction func parkAction(_ sender: UIButton) {
        for button in parkButtons {
            button.tintColor = greenColor
        }
        sender.tintColor = Theme.redColor
        fetchInfo(index: sender.tag)
    }
    
    let greenColor = UIColor(red: 0, green: 192/255, blue: 167/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func fetchInfo(index: Int) {
        switch index {
        case 1:
            let url = "http://ws.nobel168.com/GetParkingSpaces"
            let parameters: [String:Any] = ["token":"7EAF12083967", "parking_lot_serial_number":"PL003"]
            WebAPI.shared.request(urlStr: url, parameters: parameters, method: "GET") { _, data, error in
                guard let data = data, let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any], let parkingspaces = result["parkingspaces"] as? Int else{return}
                self.parkNameLabel.text = result["area"] as? String
                self.parkNameLabel.isHidden = false
                self.spaceLabel.text = "目前有\(parkingspaces)格車位"
                self.spaceLabel.isHidden = false
                self.feeLabel.isHidden = true
            }
        default:
            break
        }
    }
    
    
}
