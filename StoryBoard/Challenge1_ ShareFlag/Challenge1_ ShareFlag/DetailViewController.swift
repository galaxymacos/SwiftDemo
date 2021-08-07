//
//  DetailViewController.swift
//  DetailViewController
//
//  Created by Xun Ruan on 2021/8/7.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet var uiImageView: UIImageView!
    var image: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        // Do any additional setup after loading the view.
        if let image = image{
            uiImageView.image = UIImage(named: image)
        }
    }
    
    @objc func shareTapped(){
        guard let imageData = uiImageView.image?.jpegData(compressionQuality: 0.8) else{
            return
        }
        
        let vc = UIActivityViewController(activityItems: [imageData, image!], applicationActivities: [])
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
