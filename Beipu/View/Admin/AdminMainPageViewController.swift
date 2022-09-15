//
//  AdminMainPageViewController.swift
//  Beipu
//
//  Created by Tai Chin Huang on 2022/9/1.
//

import UIKit

protocol AdminMainPageViewControllerDelegate: AnyObject {
    func didTappedQRScanButton(_ viewController: AdminMainPageViewController)
    func didTappedLogoutButton(_ viewController: AdminMainPageViewController)
}

class AdminMainPageViewController: UIViewController {
    
    private lazy var qrScanButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "qrcode.viewfinder"), for: .normal)
        button.setTitle("掃描核銷", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo1")
        return imageView
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .themeRed
        button.layer.cornerRadius = 5
        button.setTitle("登出", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: AdminMainPageViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        setupButton()
    }
}

extension AdminMainPageViewController {
    func initView() {
        view.addSubviews(qrScanButton, imageView, logoutButton)
        
        qrScanButton.anchor(top: view.topAnchor, paddingTop: 100)
        qrScanButton.centerX(inView: imageView)
        qrScanButton.setDimensions(height: 50, width: 50)
        
        imageView.centerX(inView: view)
        imageView.centerY(inView: view)
        imageView.setDimensions(height: 75, width: 75)
        
        logoutButton.anchor(bottom: view.bottomAnchor, paddingBottom: 100)
        logoutButton.centerX(inView: imageView)
    }
    
    func setupButton() {
        qrScanButton.addTarget(self, action: #selector(qrScanButtonTapped(_:)), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped(_:)), for: .touchUpInside)
    }
    @objc func qrScanButtonTapped(_ sender: UIButton) {
        delegate?.didTappedQRScanButton(self)
    }
    @objc func logoutButtonTapped(_ sender: UIButton) {
        delegate?.didTappedLogoutButton(self)
    }
}
