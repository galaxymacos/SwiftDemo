//
//  DetailViewController.swift
//  DetailViewController
//
//  Created by Xun Ruan on 2021/8/15.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var imageName: String?
    var imagePath: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = imageName
        print(imageName!)
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageName = imageName {
            imageView.image = UIImage(contentsOfFile: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(imageName).path)
        }
        // Do any additional setup after loading the view.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
