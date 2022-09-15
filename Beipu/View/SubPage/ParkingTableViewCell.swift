//
//  ParkingTableViewCell.swift
//  Beipu
//
//  Created by Tai Chin Huang on 2022/8/16.
//

import UIKit

class ParkingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var parkingLeftLabel: UILabel!
    @IBOutlet weak var primaryChargeLabel: UILabel!
    @IBOutlet weak var secondaryChargeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: Parking) {
        numberLabel.text = model.number
        nameLabel.text = model.name
        parkingLeftLabel.text = "\(model.totalParkinglot)"
        primaryChargeLabel.text = model.primaryCharge
        print(#function)
        print(model.secondaryCharge)
        if model.secondaryCharge.count == 0 {
            secondaryChargeLabel.isHidden = true
        } else {
            secondaryChargeLabel.isHidden = false
            secondaryChargeLabel.text = model.secondaryCharge
        }
    }
    
}
