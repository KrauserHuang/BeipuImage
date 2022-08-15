//
//  WKWebViewController.swift
//
//  Created by 陳Mike on 2021/6/29.
//

import UIKit
import WebKit
//簡易的WebViewController
class WKWebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    var urlStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        webView.navigationDelegate = self
        loadWeb(urlString: urlStr)
    }
    
    func loadWeb(urlString: String){
        guard let url = URL(string: urlString) else{return}
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

//extension WKWebViewController: WKNavigationDelegate {
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        print("webview:\(webView) decidePolicyFornavigationAction:\(navigationAction) decisionHandler:\(String(describing: decisionHandler))")
//        switch navigationAction.navigationType {
//        case .linkActivated:
//            if navigationAction.targetFrame == nil {
//                webView.load(navigationAction.request)
//            }
//        default:
//            break
//        }
//    }
//}
