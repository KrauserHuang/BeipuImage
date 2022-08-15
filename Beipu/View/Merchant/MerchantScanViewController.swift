//
//  MerchantScanViewController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/8/4.
//

import UIKit
import AVFoundation
protocol MerchantScanViewControllerDelegate: AnyObject {
    func dismissSelf(_ viewController: MerchantScanViewController)
    func gotContent(_ viewController: MerchantScanViewController, content: String)
}

class MerchantScanViewController: UIViewController {
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var outView: UIView!
    @IBAction func backAction(){
        delegate?.dismissSelf(self)
    }
    
    var captureSession: AVCaptureSession?
    var videoPreviewerLayer: AVCaptureVideoPreviewLayer?
    weak var delegate: MerchantScanViewControllerDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        setQRCodeReader()
        self.navigationItem.backButtonTitle = ""
    }
//    進入此頁隱藏navigationBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
//    離開此頁顯示navigationBar
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        super.viewWillDisappear(animated)
    }
//    做出遮罩
    func setMask(){
        let maskLayer = CAShapeLayer()
        let path = CGMutablePath()
        path.addRect(cameraView.frame)
        path.addRect(outView.bounds)
        maskLayer.path = path
        maskLayer.fillRule = .evenOdd
        outView.layer.mask = maskLayer
    }
//    設定掃QRCode相機
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setMask()
        setLayer()
        setQRCodeReader()
    }
    
    func setLayer(){
//        畫出畫面四周的線
        let layer = CAShapeLayer()
        layer.frame = cameraView.bounds
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 35))
        path.addLine(to: .zero)
        path.addLine(to: CGPoint(x: 35, y: 0))
        
        path.move(to: CGPoint(x: layer.frame.maxX - 35, y: 0))
        path.addLine(to: CGPoint(x: layer.frame.maxX, y: 0))
        path.addLine(to: CGPoint(x: layer.frame.maxX, y: 35))
        
        path.move(to: CGPoint(x: 0, y: layer.frame.maxY - 35))
        path.addLine(to: CGPoint(x: 0, y: layer.frame.maxY))
        path.addLine(to: CGPoint(x: 35, y: layer.frame.maxY))
        
        path.move(to: CGPoint(x: layer.frame.maxX, y: layer.frame.maxY - 35))
        path.addLine(to: CGPoint(x: layer.frame.maxX, y: layer.frame.maxY))
        path.addLine(to: CGPoint(x: layer.frame.maxX - 35, y: layer.frame.maxY))
        
        layer.path = path.cgPath
        layer.lineWidth = 5
        layer.strokeColor = UIColor(red: 1, green: 61/255, blue: 148/255, alpha: 1).cgColor
        layer.fillColor = UIColor.clear.cgColor
        cameraView.layer.insertSublayer(layer, below: videoPreviewerLayer)
    }

}

extension MerchantScanViewController: AVCaptureMetadataOutputObjectsDelegate{
    //    從相機讀取到QRCode以後的動作
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metaDataObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject, metaDataObj.type == .qr, let str = metaDataObj.stringValue {
                print(str)
                captureSession?.stopRunning()
                delegate?.gotContent(self, content: str)
            }
        }
    }
