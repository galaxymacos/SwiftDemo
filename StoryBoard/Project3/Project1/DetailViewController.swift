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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,   // the icon of the button (action = the "share" icon)
                                                            target: self,   // the #selector method belongs to self
                                                            action: #selector(shareTapped)  // when you are tapped, call...
                                                            )
        navigationItem.largeTitleDisplayMode = .never   // Only for this item, use this display mode
        if let imageToLoad = selectedImage{
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    // let user focus
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnTap = true
//        print("true")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.hidesBarsOnTap = false
//        print("false")
    }
    
    // @objc because this method will get called by the underlying Objective-C operating system (the UIBarButtonItem)
    @objc func shareTapped(){
        // try to compress the image in the image view
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else{
            print("No image found")
            return
        }
        // the iOS method of sharing content with other apps and services
        let vc = UIActivityViewController(activityItems: [image, selectedImage!], applicationActivities: [])
        
        // tells iOS to anchor the activity view controller to the right bar item (the share button)
        // ONLY ON IPAD (since there is not enough space on iPhone)
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
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
