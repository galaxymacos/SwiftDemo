//
//  ViewController.swift
//  Project4
//
//  Created by Xun Ruan on 2021/8/5.
//

import UIKit
import WebKit

// UIViewController is the class we inherit, and WKNavigationDelegate is the protocol we conform to
class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()   // Create a WKWebView()
        webView.navigationDelegate = self   // tell UIKit this class can handle the navigation function
        view = webView  // set it here or it is too late
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = URL(string: "https://www.hackingwithswift.com")!  // URL(string) will create an url?
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
    }
    
    @objc func openTapped(){
        // Action sheet is created using UIAlertController, and option is added using UIAlertAction
        let ac = UIAlertController(title: "Open Page...", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }

    func openPage(action: UIAlertAction){
        let url = URL(string: "https://"+action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    // A callback method that runs when the webview finish loading
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // title means the navigation bar title
        title = webView.title
    }
}

