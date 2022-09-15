//
//  NaviDescriptViewController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/7/24.
//

import UIKit
protocol NaviDescriptViewControllerDelegate: AnyObject {
    func nextAction(_ viewController: NaviDescriptViewController)
}

class NaviDescriptViewController: UIViewController {
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextAction(){
        delegate?.nextAction(self)
    }

    var questNo = 0
    var tempDescri = [
        "",
        "謎題1.\n此建築為當地信仰中心，主祀觀音菩薩，開墾之初，與原住民爭戰屢有傷亡，墾民隘丁都會前往禱祝，祈求平安順利。您能找到這個地方在哪裡嗎？只要找到地方並對他拍照，便是成功就算解迷成功囉！",
        "謎題2.\n建於1946年，在當時堪稱風華絕代的洋式建築，呈現初中西融合的形式風格。半圓拱、凸窗等古典建築技法與裝飾紋樣來自歐洲傳統，從建築外觀即可欣賞多種高難度且精巧的泥作工法。您能找到這個地方在哪裡嗎？只要找到地方並對他拍照，便是成功就算解迷成功囉！",
        "謎題3.\n與某人相關，出身北埔新姜望族，臺灣攝影先驅者，與張才、李鳴雕三人有「臺北攝影三劍客」之合稱。您能找到這個地方在哪裡嗎？只要找到地方並對他拍照，便是成功就算解迷成功囉！",
        "謎題4.\n為一休憩地點，此地址位於秀巒公園，添建碑宇亭閣。您能找到這個地方在哪裡嗎？只要找到地方並對他拍照，便是成功就算解迷成功囉！",
        "謎題5.\n位於新竹縣北埔鄉的國定古蹟，原為中華民國第一級古蹟中，唯一的宅第類古蹟，建築形式為兩進一院之四合院格局，其兩側還各有一條外護龍。右外護龍於1935年大地震後改建為日式建築，而左外護龍目前仍維持清代原有格局。您能找到這個地方在哪裡嗎？只要找到地方並對他拍照，便是成功就算解迷成功囉！"
    ]
    weak var delegate: NaviDescriptViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        descriptLabel.text = tempDescri[questNo]
        Theme().setThemeLayer(nextButton)
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
