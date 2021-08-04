//
//  ViewController.swift
//  Project1
//
//  Created by Xun Ruan on 2021/8/4.
//

import UIKit

// One screen of information
class ViewController: UIViewController {
    var pictures: [String] = []
    // After the view has been loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        for item in items{
            if item.hasPrefix("nssl"){
                pictures.append(item)
            }
        }
        print(pictures)
        
        
        
    }


}

