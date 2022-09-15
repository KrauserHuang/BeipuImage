//
//  ParkingViewController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/7/5.
//

import UIKit

struct Parking {
    let number: String
    var name: String
    var totalParkinglot: String
    let primaryCharge: String
    let secondaryCharge: String
}

class ParkingViewController: UIViewController {
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet var parkButtons: [UIButton]!
    @IBOutlet weak var parkNameLabel: UILabel!
    @IBOutlet weak var spaceLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBAction func parkAction(_ sender: UIButton) {
        for button in parkButtons {
            button.tintColor = greenColor
        }
        sender.tintColor = Theme.redColor
//        fetchInfo(index: sender.tag)
    }
    
    let greenColor = UIColor(red: 0, green: 192/255, blue: 167/255, alpha: 1)
    let parkingImage = UIImage.parkingsign
//    let blueParkingImageView = parkingImage?.withTintColor(.blue, renderingMode: .automatic)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ParkingTableViewCell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: ParkingTableViewCell.reuseIdentifier())
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.isUserInteractionEnabled = false
        return tableView
    }()
    
    private var parkingInfos = [
        Parking(number: "", name: "", totalParkinglot: "總停車位", primaryCharge: "收費標準", secondaryCharge: ""),
        Parking(number: "1", name: "", totalParkinglot: "0", primaryCharge: "20/hr", secondaryCharge: ""),
        Parking(number: "2", name: "北埔街停車場", totalParkinglot: "31", primaryCharge: "50/次(平日)", secondaryCharge: "100/次(假日)"),
        Parking(number: "3", name: "無具名停車場", totalParkinglot: "8", primaryCharge: "80/次", secondaryCharge: ""),
        Parking(number: "4", name: "哈客愛周邊停車場", totalParkinglot: "11", primaryCharge: "50/次", secondaryCharge: ""),
        Parking(number: "5", name: "私人停車場", totalParkinglot: "168", primaryCharge: "20/hr(平日)", secondaryCharge: "30/hr(假日)"),
        Parking(number: "6", name: "有樹林的停車場", totalParkinglot: "80", primaryCharge: "50/次", secondaryCharge: "")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchInfo(index: 1)

        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: mapImageView.bottomAnchor, constant: 50),
//            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            tableView.topAnchor.constraint(equalTo: mapImageView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func fetchInfo(index: Int) {
        switch index {
        case 1:
            let url = "http://ws.nobel168.com/GetParkingSpaces"
            let parameters: [String:Any] = ["token":"7EAF12083967", "parking_lot_serial_number":"PL003"]
            WebAPI.shared.request(urlStr: url, parameters: parameters, method: "GET") { _, data, error in
                guard let data = data, let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any], let parkingspaces = result["parkingspaces"] as? Int else{return}
//                let name = result["area"] as? String
                self.parkingInfos[1].name = "北埔公有停車場"
                self.parkingInfos[1].totalParkinglot = "\(parkingspaces)/165"
//                self.parkNameLabel.text = result["area"] as? String
//                self.parkNameLabel.isHidden = false
//                self.spaceLabel.text = "目前有\(parkingspaces)格車位"
//                self.spaceLabel.isHidden = false
//                self.feeLabel.isHidden = true
                self.tableView.reloadData()
            }
        default:
            break
        }
    }
}

extension ParkingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parkingInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ParkingTableViewCell.reuseIdentifier(), for: indexPath) as? ParkingTableViewCell else { return UITableViewCell() }
        let parkingInfo = parkingInfos[indexPath.row]
        cell.configure(with: parkingInfo)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
