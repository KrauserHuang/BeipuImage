//
//  MapViewController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/7/5.
//

import UIKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapScrollView: UIScrollView!
    @IBOutlet weak var mapImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapScrollView.delegate = self
        mapScrollView.minimumZoomScale = 0.1
        mapScrollView.maximumZoomScale = 4.0
        mapScrollView.zoomScale = 1.0
    }
    
}

extension MapViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mapImageView
    }
}
