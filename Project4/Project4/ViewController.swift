//
//  ViewController.swift
//  Project4
//
//  Created by Xun Ruan on 2021/8/5.
//

import UIKit
import WebKit

// UIViewController is the class we inherit, and WKNavigationDelegate is the protocol we conform to
class ViewController: UITableViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com", "google.com", "baidu.com"]
    
//    override func loadView() {
//        webView = WKWebView()   // Create a WKWebView()
//        webView.navigationDelegate = self   // tell UIKit this class can handle the navigation function
//        view = webView  // set it here or it is too late
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Websites"
        // Do any additional setup after loading the view.
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    @objc func openTapped(){
        // Action sheet is created using UIAlertController, and option is added using UIAlertAction
        let ac = UIAlertController(title: "Open Page...", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
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
    
    // Decides whether we allows or refuses a visit to a site
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host{
            for website in websites {
                if host.contains(website){
                    decisionHandler(.allow)
                    print("allow")
                    return
                }
            }
        }
        if url != nil{
            print(url)
            let ac = UIAlertController(title: "Block", message: "Not allow to visit", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
            decisionHandler(.cancel)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        webView = WKWebView()   // Create a WKWebView()
        webView.navigationDelegate = self   // tell UIKit this class can handle the navigation function
        view = webView  // set it here or it is too late
        let url = URL(string: "https://"+websites[indexPath.row])!  // URL(string) will create an url?
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()    // only take up the space of its content
        let progressButton = UIBarButtonItem(customView: progressView)  // Wrap up UIProgressView in a UIBarButtonItem so that it can go into our toolbar
        
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let goback = UIBarButtonItem(barButtonSystemItem: .cancel, target: webView, action: #selector(webView.goBack))
        let goForward = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webView, action: #selector(webView.goForward))
        toolbarItems = [goback, progressButton, spacer, refresh, goForward]
        
        navigationController?.isToolbarHidden = false
        
        // #keypath let complier to check your code is right, that WKWebView actually has the estimatedProgress property
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
}

