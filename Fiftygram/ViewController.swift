//
//  ViewController.swift
//  Fiftygram
//
//  Created by ThureinTun on 09/07/2024.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    let context = CIContext()
    var original : UIImage?
    @IBOutlet var imageView : UIImageView!
    @IBAction func choosePhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            navigationController?.present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func applySepia(){
        
        guard let original = original else {
            return
        }
        let filter = CIFilter(name: "CISepiaTone")
        display(filter: filter!) 
//        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
//        filter?.setValue(CIImage(image: original), forKeyPath: kCIInputImageKey)
//        let output = filter?.outputImage
//        imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
    }
    
    @IBAction func applyNoir(){
        guard let original = original else {
            return
        }
        let filter = CIFilter(name: "CIPhotoEffectNoir")
        display(filter: filter!)
       
    }
    
    @IBAction func applyVintage(){
        guard let original = original else {
            return
        }
        let filter = CIFilter(name: "CIPhotoEffectProcess")
        display(filter: filter!)
    }
    
    
    func display(filter:CIFilter){
        filter.setValue(CIImage(image: original!), forKeyPath: kCIInputImageKey)
        let output = filter.outputImage
        imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.dismiss(animated: true, completion: nil)
       if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
           imageView.image = image
           original = image
        }
    }
}

