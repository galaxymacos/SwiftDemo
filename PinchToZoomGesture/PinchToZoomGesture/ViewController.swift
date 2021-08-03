//
//  ViewController.swift
//  PinchToZoomGesture
//
//  Created by Xun Ruan on 2021/8/3.
//

import UIKit

class ViewController: UIViewController {

    // Create a custom view
    private let myView: UIView = {
        let myView = UIView()
        myView.backgroundColor = .systemPurple
        return myView
    }()
    
    private let size: CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // add a subview
        view.addSubview(myView)
        myView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        myView.center = view.center // Set this view to be the center of the main view
        
        addGesture()
    }
    
    // Similar to .onTagGesture{} in swiftUI
    private func addGesture(){
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        myView.addGestureRecognizer(pinchGesture)
    }

    @objc private func didPinch(_ gesture: UIPinchGestureRecognizer){
        if gesture.state == .changed{
            let scale = gesture.scale
            myView.frame = CGRect(x: 0, y: 0, width: size * scale, height: size * scale)
            myView.center = view.center
        }
    }

}

