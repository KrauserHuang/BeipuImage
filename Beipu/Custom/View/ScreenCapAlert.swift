//
//  ScreenCapAlert.swift
//
//  Created by 陳Mike on 2021/7/13.
//

import UIKit

//截圖或拍照時發出提醒
protocol ScreenCapAlert {
    func setScreenCapAlert()
    func removeScreenCapAlert()
}
//不讓這個extension套用至所有UIViewController
fileprivate extension UIViewController {
//    只能在這裡實作ObjC的function
    @objc func screenCapAlert(){
        let backView = UIView()
        backView.backgroundColor = .black
        backView.alpha = 0.6
        backView.frame = view.bounds
        UIApplication.shared.keyWindow?.addSubview(backView)
        
        let alert = UIAlertController(title: "安全提醒", message: "螢幕已擷取，請妥善保管截圖及錄影檔案，以避免個人資訊外流。", preferredStyle: .alert)
                
        let done = UIAlertAction(title: "確定", style: .default) { (action) in
            backView.removeFromSuperview()
        }
        alert.addAction(done)
        present(alert, animated: true, completion: nil)
    }
}

extension ScreenCapAlert where Self: UIViewController {
    func setScreenCapAlert() {
//        註冊截圖及錄影通知
        NotificationCenter.default.addObserver(self, selector: #selector(screenCapAlert), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(screenCapAlert), name: UIScreen.capturedDidChangeNotification, object: nil)
        
//        判斷是否錄影中
        let sc = UIScreen.main
        if sc.isCaptured {
            screenCapAlert()
        }
    }
    
    
    func removeScreenCapAlert(){
//        註銷截圖及錄影通知
        NotificationCenter.default.removeObserver(self, name: UIApplication.userDidTakeScreenshotNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIScreen.capturedDidChangeNotification, object: nil)
    }
}
