//
//  NaviCameraViewController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/7/24.
//

import UIKit
import AVFoundation
import MapKit
import CoreLocation

protocol NaviCameraViewControllerDelegate: AnyObject {
    func getAction(_ viewController: NaviCameraViewController, arIndex: Int, distance: Double)
}

class NaviCameraViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, CLLocationManagerDelegate {
    var captureSession: AVCaptureSession?
    var videoPreviewerLayer: AVCaptureVideoPreviewLayer?
    var takePhoto:UIImage?
    @IBOutlet weak var cameraImageView: UIImageView!
    @IBOutlet weak var catchButton: UIButton!
    //用來接上一頁給的值
//    var arInfo: ARInfo?
    var arIndex = 0
    var myLocationManager :CLLocationManager!
    var myMapView :MKMapView!
    weak var delegate: NaviCameraViewControllerDelegate?
    var currentLat = 0.0
    var currentLong = 0.0
    let arLocations = [
        (0,0),
        (24.69994638181437, 121.0582215816484), //慈天宮 (實際差距26公尺)
        (24.70039501169668, 121.05789269699194), //姜阿新洋樓 (實際差距29公尺)
        (24.69863477847924, 121.05826535466362), //鄧南光影像紀念館 (實際差距0)
        (24.699555364368607, 121.0591729273457), //慈母亭 (實際差距8公尺)
        (24.70097752180357, 121.0579163988429) //金廣福公館 (實際差距81公尺)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 建立一個 CLLocationManager
        myLocationManager = CLLocationManager()

        // 設置委任對象
        myLocationManager.delegate = self

        // 距離篩選器 用來設置移動多遠距離才觸發委任方法更新位置
        myLocationManager.distanceFilter =
            kCLLocationAccuracyNearestTenMeters

        // 取得自身定位位置的精確度
        myLocationManager.desiredAccuracy =
            kCLLocationAccuracyNearestTenMeters
        
        setQRCodeReader()
        
        switch CLLocationManager.authorizationStatus() {
        // 首次使用 向使用者詢問定位自身位置權限
        case .notDetermined:
            // 取得定位服務授權
            myLocationManager.requestWhenInUseAuthorization()
            // 開始定位自身位置
            myLocationManager.startUpdatingLocation()
        // 使用者已經拒絕定位自身位置權限
        case .denied, .restricted:
            // 提示可至[設定]中開啟權限
            let alertController = UIAlertController(
                title: "定位權限已關閉",
                message:
                    "如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟",
                preferredStyle: .alert)
            let okAction = UIAlertAction(
                title: "確認", style: .default, handler:nil)
            alertController.addAction(okAction)
            self.present(
                alertController,
                animated: true, completion: nil)
        // 使用者已經同意定位自身位置權限
        case .authorizedWhenInUse, .authorizedAlways:
            // 開始定位自身位置
            myLocationManager.startUpdatingLocation()
        default:
            break
        }
    }
    

    func setQRCodeReader(){
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {return}
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            let output = AVCaptureMetadataOutput()
            captureSession?.addOutput(output)
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            output.metadataObjectTypes = [.qr]
            videoPreviewerLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewerLayer?.videoGravity = .resizeAspectFill
            videoPreviewerLayer?.frame.size = view.bounds.size
            view.layer.insertSublayer(videoPreviewerLayer!, at: 0)
            captureSession?.startRunning()
        }catch{
            print(error)
        }
    }

    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 停止定位自身位置
        myLocationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        // 印出目前所在位置座標
        let currentLocation :CLLocation =
            locations[0] as CLLocation
        currentLat = currentLocation.coordinate.latitude
        currentLong = currentLocation.coordinate.longitude
    }
    
    //判斷到哪個頁面
    @IBAction func judgePageAction(_ sender: Any) {
//        guard let user = UserService.shared.user, let arinfo = arInfo else {return}
//        let url = API_URL + URL_ARGPS
//        //解析API資料
//        let parameter = "member_id=\(user.member_id)&member_pwd=\(user.member_pwd)&loc_lng1=\(arinfo.ar_longitude)&loc_lat1=\(arinfo.ar_latitude)&loc_lng2=\(currentLong)&loc_lat2=\(currentLat)"
//        WebAPI.shared.request(urlString: url, parameters: parameter) { isSuccess, data, error in
//            guard isSuccess , let data = data, let results = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let distance = results["responseMessage"] as? Int else { return }
//            print(String(data: data, encoding: .utf8))
//            print(distance)
//            self.delegate?.getAction(self, arinfo: arinfo, distance: distance)
//
//            print("目前經度:\(self.currentLong)")
//            print("目前緯度:\(self.currentLat)")
//            print("=========================")
//            print("目標經度:\(self.arInfo?.ar_longitude)")
//            print("目標緯度:\(self.arInfo?.ar_latitude)")
//        }
        let distance = getDistance(lat1: currentLat,
                                   lng1: currentLong,
                                   lat2: arLocations[arIndex].0,
                                   lng2: arLocations[arIndex].1)
        delegate?.getAction(self, arIndex: arIndex, distance: distance)
    }
    
    //根據角度計算弧度
    func radian(d:Double) -> Double {
         return d * Double.pi/180.0
    }
//    //根據弧度計算角度
//    func angle(r:Double) -> Double {
//         return r * 180/Double.pi
//    }
    //根據兩點經緯度計算兩點距離
    func getDistance(lat1:Double,lng1:Double,lat2:Double,lng2:Double) -> Double {
        let EARTH_RADIUS = 6378137.0

        let radLat1 = radian(d: lat1)
        let radLat2 = radian(d: lat2)

        let radLng1 = radian(d: lng1)
        let radLng2 = radian(d: lng2)

        let a = radLat1 - radLat2
        let b = radLng1 - radLng2

        var distance = 2 * asin(sqrt(pow(sin(a/2), 2) + cos(radLat1) * cos(radLat2) * pow(sin(b/2), 2)))
        distance = distance * EARTH_RADIUS
        return distance
    }
}

