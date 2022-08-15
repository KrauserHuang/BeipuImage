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
