//
//  DetailViewController.swift
//  DetailViewController
//
//  Created by Xun Ruan on 2021/8/4.
//

import UIKit

class DetailViewController: UIViewController {
    
    // @IBOutlet: This attribute is used to tell XCode that there's a connection between thsi line of code and Interface Builder
    // UIImageView!: This means that that UIImageView may be there or it may not be there, but we're certain it definitely will be there by the time we want to use it.
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = selectedImage
        navigationItem.largeTitleDisplayMode = .never   // Only for this item, use this display mode
        if let imageToLoad = selectedImage{
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    // let user focus
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.hidesBarsOnTap = false
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
