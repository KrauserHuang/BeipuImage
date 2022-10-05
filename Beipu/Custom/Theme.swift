//
//  Theme.swift
//  Beipu
//
//  Created by 陳Mike on 2022/6/30.
//

import UIKit

class Theme {
    enum ThemeLayerGradientDirection {
        case Horizon, Vertical
    }
    
    static let redColor = UIColor(red: 1, green: 61/255, blue: 148/255, alpha: 1)
    
    func getThemeLayer(size: CGSize, direct: ThemeLayerGradientDirection = .Horizon) -> CALayer{
        let layer = CAGradientLayer()
        layer.frame.size = size
        layer.colors = [UIColor(red: 1, green: 101/255, blue: 90/255, alpha: 1).cgColor, UIColor(red: 1, green: 61/255, blue: 148/255, alpha: 1).cgColor]
        switch direct {
        case .Horizon:
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint(x: 1, y: 0)
        case .Vertical:
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint(x: 0, y: 1)
        }
        
        return layer
    }
    func setThemeLayer(_ view: UIView) {
        let layer = getThemeLayer(size: view.frame.size)
        view.layer.insertSublayer(layer, at: 0)
        view.layer.masksToBounds = true
    }
    
}

typealias Completion = (_ success: Bool, _ response: AnyObject?) -> Void
typealias Handler = () -> Void

enum ReturnCode {
    static let RETURN_SUCCESS = (101, "取得成功")
    static let MALL_RETURN_SUCCESS = ("0x0200", "SUCCESS")
}

public func Base64(string: String) -> String {
    let data = string.data(using: .utf8)
    return data?.base64EncodedString(options: .lineLength64Characters) ?? ""
}

class Alert {

    class func comfirmBeforeLogout(title: String?, msg: String, vc: UIViewController, handler: @escaping Handler) {

        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)

        let confirm = UIAlertAction(title: "登出", style: .destructive) { (_) in
            handler()
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)

        alert.addAction(confirm)
        alert.addAction(cancel)
        vc.present(alert, animated: true, completion: nil)
    }

    class func showConfirm(title: String?, msg: String, vc: UIViewController, handler: @escaping Handler) {

        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)

        let confirm = UIAlertAction(title: "確定", style: .default) { (_) in
            handler()
        }

        let cancel = UIAlertAction(title: "取消", style: .cancel) { (_) in

        }

        alert.addAction(confirm)
        alert.addAction(cancel)
        vc.present(alert, animated: true, completion: nil)
    }

    class func showLogout(title: String?, msg: String?, vc: UIViewController, handler: @escaping Handler) {

        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)

        let logout = UIAlertAction(title: "登出", style: .destructive) { (_) in
            handler()
        }

        let cancel = UIAlertAction(title: "取消", style: .cancel) { (_) in

        }

        alert.addAction(logout)
        alert.addAction(cancel)
        vc.present(alert, animated: true, completion: nil)
    }

    class func showMessage(title: String?, msg: String, vc: UIViewController, handler: Handler? = nil) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)

        let done = UIAlertAction(title: "確定", style: .default) { (_) in
            if handler != nil {
                handler!()
            }
        }
        alert.addAction(done)
        vc.present(alert, animated: true, completion: nil)
    }

    class func showSecurityAlert(title: String?, msg: String, vc: UIViewController, handler: Handler? = nil) {

        let blurEffect = UIBlurEffect(style: .light)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = vc.view.bounds

        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)

        let done = UIAlertAction(title: "確定", style: .default) { (_) in
            blurVisualEffectView.removeFromSuperview()
            if handler != nil {
                handler!()
            }
        }
        alert.addAction(done)

        vc.view.addSubview(blurVisualEffectView)
        vc.present(alert, animated: true, completion: nil)

    }

    class func accountDeletionAlert(title: String?, msg: String, vc: UIViewController, handler: Handler? = nil) {

        let blurEffect = UIBlurEffect(style: .light)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = vc.view.bounds

        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let done = UIAlertAction(title: "確定", style: .destructive) { (_) in
            blurVisualEffectView.removeFromSuperview()
            if handler != nil {
                handler!()
            }
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (_) in
            blurVisualEffectView.removeFromSuperview()
        }
        alert.addAction(done)
        alert.addAction(cancel)

        vc.view.addSubview(blurVisualEffectView)
        vc.present(alert, animated: true, completion: nil)
    }
}
