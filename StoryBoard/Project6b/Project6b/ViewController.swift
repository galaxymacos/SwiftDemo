//
//  ViewController.swift
//  Project6b
//
//  Created by Xun Ruan on 2021/8/8.
//

import UIKit

class ViewController: UIViewController {
    
    let metric:[String: Int] = ["labelHeight": 88]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false    // Let us add our constraint
        label1.backgroundColor = .red
        label1.text = "THESE"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .cyan
        label2.text = "ARE"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .yellow
        label3.text = "SOME"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .green
        label4.text = "AWESOME"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .orange
        label5.text = "LABELS"
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
//        let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
        // view.addConstraint(): this adds an array of constraints to our view controller's view
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label1]|", options: [], metrics: nil, views: viewsDictionary))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label2]|", options: [], metrics: nil, views: viewsDictionary))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label3]|", options: [], metrics: nil, views: viewsDictionary))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label4]|", options: [], metrics: nil, views: viewsDictionary))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label5]|", options: [], metrics: nil, views: viewsDictionary))
        
//        for label in viewsDictionary.keys {
//            view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", // horizontally, I want my label to go edge to dedge in my view
//                                                                options: [],
//                                                                metrics: nil,
//                                                                views: viewsDictionary))    // let the VFL knows what's the string "label" by finding the target view in dictionary
//        }
        
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewsDictionary))
        // ==88 means the height is 88 points
        
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight)]-[label2(labelHeight)]-[label3(labelHeight)]-[label4(labelHeight)]-[label5(labelHeight)]-(>=10)-|", options: [], metrics: nil, views: viewsDictionary))
//
        
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|",
//                                                           options: [],
//                                                           metrics: metric, // metric allows us to store some same number into a variable, and changing that variable in one place can change all
//                                                           views: viewsDictionary))
        var previous: UILabel?
        
        for label in [label1, label2, label3, label4, label5] {
            // Equalize the width of the current anchor to the parents' anchor
//            label.widthAnchor.constraint(equalToConstant).isActive = true
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: 50).isActive = true  // Make the label's width the the half of the width of its parent plus 50 pixels
            
//            label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true // Make the view attach to the left edge of its parent
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            
//            label.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height-50) / 5.0).isActive = true
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2, constant: -10).isActive = true
            if let previous = previous{
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            }
            else{   // Push view away from safe area
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
                
            }
            previous = label
        }
    }

}

