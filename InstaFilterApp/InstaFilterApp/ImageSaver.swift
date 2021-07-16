//
//  ImageSaver.swift
//  ImageSaver
//
//  Created by Xun Ruan on 2021/7/15.
//

import UIKit

class ImageSaver: NSObject{
    var successHandler:(()->Void)?
    var failureHandler:((Error)->Void)?
    
    func writeToPhotoAlbum(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        if let error = error {
            failureHandler?(error)
        }
        else{
            successHandler?()
        }
    }
}
