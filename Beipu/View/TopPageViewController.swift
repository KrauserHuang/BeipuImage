//
//  TopPageViewController.swift
//  Beipu
//
//  Created by 陳Mike on 2022/6/24.
//

import UIKit
protocol TopPageViewControllerDelegate: AnyObject {
    func planAction(_ viewController: TopPageViewController)
    func mapAction(_ viewController: TopPageViewController)
    func naviAction(_ viewController: TopPageViewController)
    func healthAction(_ viewController: TopPageViewController)
    func parkingAction(_ viewController: TopPageViewController)
    func shopAction(_ viewController: TopPageViewController)
}

class TopPageViewController: UIViewController {
    @IBOutlet weak var bannerScrollView: UIScrollView!
    @IBOutlet weak var bannerStack: UIStackView!
    @IBOutlet weak var bannerPageControl: UIPageControl!
    @IBOutlet weak var shopCollectionView: UICollectionView!
    
    @IBAction func bannerPageChangeAction(_ sender: UIPageControl) {
        let point = CGPoint(x: bannerScrollView.bounds.width * CGFloat(sender.currentPage), y: 0)
        bannerScrollView.setContentOffset(point, animated: true)
    }
    @IBAction func planAction(_ sender: Any) {
        delegate?.planAction(self)
    }
    @IBAction func mapAction(_ sender: Any) {
        delegate?.mapAction(self)
    }
    @IBAction func naviAction(_ sender: Any) {
        delegate?.naviAction(self)
    }
    @IBAction func healthAction(_ sender: Any) {
        delegate?.healthAction(self)
    }
    @IBAction func parkingAction(_ sender: Any) {
        delegate?.parkingAction(self)
    }
    @IBAction func shopAction(_ sender: Any) {
        delegate?.shopAction(self)
    }
    
    var delegate: TopPageViewControllerDelegate?
    var bannerList = [Banner](){
        didSet{
            for banner in self.bannerList {
                banner.renewImage = { [weak self] in
                    self?.readScroll()
                }
            }
        }
    }
    var storeList = [Store](){
        didSet{
            shopCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        自動輪播圖片時間
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(scroll), userInfo: nil, repeats: true)
        bannerScrollView.delegate = self
        fetchBanner()
        fetchStore()
    }
    
    @objc func scroll(){
//        輪播圖片
        if bannerPageControl.currentPage == bannerPageControl.numberOfPages-1 {
            bannerPageControl.currentPage = 0
        }else {
            bannerPageControl.currentPage += 1
        }
        bannerPageChangeAction(bannerPageControl)
    }
    
    func fetchBanner(){
        let url = API_URL + URL_BANNERLIST
        WebAPI.shared.request(urlString: url, parameters: "") { isSuccess, data, error in
            guard isSuccess, let data = data, let results = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {return}
            var banners = [Banner]()
            for result in results{
                let banner = Banner(from: result)
                banners.append(banner)
            }
            self.bannerList = banners
        }
    }
    
    func fetchStore(){
        let url = API_URL + URL_STORELIST
        WebAPI.shared.request(urlString: url, parameters: "") { isSuccess, data, error in
            guard isSuccess, let data = data, let results = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {return}
            var list = [Store]()
            for result in results {
                list.append(Store(from: result))
            }
            self.storeList = list
        }
    }
    
    func readScroll(){
//        移除輪播圖原有圖片
        for subview in bannerStack.subviews{
            subview.removeFromSuperview()
        }
//        加入輪播圖
        for banner in bannerList {
            let imageView = UIImageView(frame: bannerScrollView.bounds)
            imageView.image = banner.banner_picture
            imageView.contentMode = .scaleAspectFill
//            imageView.layer.cornerRadius = 5
            imageView.layer.masksToBounds = true
//            let ratio = banner.banner_picture.size.width / banner.banner_picture.size.height
//            let height = UIScreen.main.bounds.width - 30 / ratio
//            imageView.frame.size = CGSize(width: UIScreen.main.bounds.width - 30, height: height > 180 ? 180: height)
            bannerStack.addArrangedSubview(imageView)
            if bannerStack.arrangedSubviews.count == 1{
                imageView.widthAnchor.constraint(equalTo: bannerScrollView.frameLayoutGuide.widthAnchor).isActive = true
                imageView.heightAnchor.constraint(equalTo: bannerScrollView.frameLayoutGuide.heightAnchor).isActive = true
            }
        }
//        設定小圓點
        bannerPageControl.numberOfPages = bannerStack.arrangedSubviews.count
    }
}
extension TopPageViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        設定拖曳輪播頁面時更新小圓點
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        bannerPageControl.currentPage = Int(page)
    }
}
extension TopPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        storeList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCollectionViewCell", for: indexPath) as! ShopCollectionViewCell
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        cell.store = storeList[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let store = storeList[indexPath.row]
        let website = store.store_website
        if website.count != 0 {
            let vc = WKWebViewController()
            vc.urlStr = website
            navigationController?.pushViewController(vc, animated: true)
        } else {
            print("沒網址可去拉")
        }
    }
}

class ShopCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopPromoLabel: UILabel!
    @IBOutlet weak var shopDistLabel: UILabel!
    
    var store: Store? {
        didSet{
            DispatchQueue.main.async {
                self.setStore()
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        setStore()
    }
    func setStore() {
        guard let store = store else{return}
        shopImage?.image = store.store_picture
        shopNameLabel?.text = store.store_name
        shopPromoLabel.text = store.store_news
        shopDistLabel.text = "\(store.distance)KM"
        store.renewImage = {[weak self] in
            DispatchQueue.main.async {
                self?.shopImage.image = store.store_picture
            }
        }
    }

}
