//
//  AdminQRScanViewController.swift
//  Beipu
//
//  Created by Tai Chin Huang on 2022/9/1.
//

import UIKit
import AVFoundation

protocol AdminQRScanViewControllerDelegate: AnyObject {
    func didTappedDismissButton(_ viewController: AdminQRScanViewController)
    func didFinishedScan(_ viewController: AdminQRScanViewController)
}

class AdminQRScanViewController: UIViewController {
    
    weak var delegate: AdminQRScanViewControllerDelegate?
    
    private let dismissButton = makeIconButton(imageName: "Icons_24px_Close",
                                               imageColor: .white,
                                               imageWidth: 20,
                                               imageHeight: 20,
                                               backgroundColor: .systemGray5,
                                               cornerRadius: 36/2)
    private lazy var titleLabel = makeLabel(withTitle: "掃描車牌 QR Code",
                                            font: .systemFont(ofSize: 20, weight: .bold),
                                            textColor: .white)
    private lazy var coverView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.4
        return view
    }()
    
    private lazy var cameraView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        setupButton()
        configureQRReader()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setMask()
        setLayer()
    }
}
// MARK: - internal functions
extension AdminQRScanViewController {
    func initView() {
        view.addSubviews(coverView, dismissButton, titleLabel, cameraView)
        dismissButton.anchor(top: view.topAnchor,
                             left: view.leftAnchor,
                             paddingTop: 56,
                             paddingLeft: 24)
        dismissButton.setDimensions(height: 36, width: 35)
        
        titleLabel.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: 56)
        titleLabel.centerY(inView: dismissButton)
        
        cameraView.anchor(top: titleLabel.bottomAnchor,
                          left: view.leftAnchor,
                          right: view.rightAnchor,
                          paddingTop: 100,
                          paddingLeft: 75,
                          paddingRight: 75,
                          height: UIScreen.main.bounds.size.width - 150)
        
        coverView.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor)
    }
    func setupButton() {
        dismissButton.addTarget(self, action: #selector(dismissVC(_:)), for: .touchUpInside)
    }
    @objc func dismissVC(_ sender: UIButton) {
        delegate?.didTappedDismissButton(self)
//        self.dismiss(animated: true, completion: nil)
    }
    
    func configureQRReader() {
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Fail to get the camera device")
            return
        }
        do {
            // 使用前一個裝置物件來取得AVCaptureDeviceInput類別的實例
            let input = try AVCaptureDeviceInput(device: captureDevice)
            // 在擷取session設定輸入裝置
            captureSession.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [.qr]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = .resizeAspectFill
//            videoPreviewLayer?.frame = view.layer.bounds
            videoPreviewLayer?.frame.size = view.bounds.size
//            view.layer.addSublayer(videoPreviewLayer!)
            view.layer.insertSublayer(videoPreviewLayer!, at: 0)
            // 開始影片的擷取
            captureSession.startRunning()
        } catch {
            print(error)
            return
        }
    }
    
    func setMask() {
        let maskLayer = CAShapeLayer()
        let path = CGMutablePath()
        path.addRect(cameraView.frame)
        path.addRect(coverView.bounds)
        maskLayer.path = path
        maskLayer.fillRule = .evenOdd
        coverView.layer.mask = maskLayer
    }
    
    func setLayer() {
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
        cameraView.layer.insertSublayer(layer, below: videoPreviewLayer)
    }
}
// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension AdminQRScanViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metaDataObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
           metaDataObj.type == .qr,
           let str = metaDataObj.stringValue {
            print("回吐qrcode:\(str)")
            captureSession.stopRunning()
            
            let qrcode = str
            
//            Alert.showMessage(title: "登記車牌\(plateNo)", msg: "請掃描車機QR Code", vc: self) {
                self.delegate?.didFinishedScan(self)
//            }
        } else {
            print("錯誤metaData")
        }
    }
}
