//
//  PhotosViewController.swift
//  Photos
//
//  Created by 刘洋 on 7/6/19.
//  Copyright © 2019 Yang Liu. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class PhotosViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var myphoto: UIImageView!
    var imageData: NSData!
    @IBOutlet weak var photobiaoti: UINavigationItem!
    @IBOutlet weak var imagetitle: UITextField!
    @IBOutlet weak var baocun: UIBarButtonItem!
    var images = [ImageDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photobiaoti.title = ""
        imagetitle.text = nil
        imagetitle.isEnabled = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func importPhoto(_ sender: Any) {
        let photo = UIImagePickerController()
        photo.delegate = self
        photo.sourceType = UIImagePickerControllerSourceType.photoLibrary
        photo.allowsEditing = false
        self.present(photo, animated: true, completion: nil)
    }
    
    @IBAction func deletePhoto(_ sender: Any) {
        if myphoto == nil {
            tixing(message: "There is no photo to delete.")
        }else {
            myphoto.image = nil
            imagetitle.text = ""
            tixing(message: "The photo has been deleted.")
            imagetitle.isEnabled = false
        }
    }
    @IBAction func takePicture(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.camera
        image.allowsEditing = false
        self.present(image, animated: true, completion: nil)
        }else {
             tixing(message: "This device does not have a camera.")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let photo = info[UIImagePickerControllerOriginalImage] as? UIImage {
            myphoto.image = photo
            imageData = UIImagePNGRepresentation(photo)! as NSData
            imagetitle.isEnabled = true
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let newPhoto = NSEntityDescription.insertNewObject(forEntityName: "ImageDetails", into: context)
            newPhoto.setValue(imageData, forKey: "imageData")
            do
            {
                try context.save()
            }
            catch {
                tixing(message: "data could not be saved!")
            }
            
        }
        else {
             tixing(message: "The photo imported successfully!")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func tixing(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) {
            (alertAction) -> Void in
            print("selected")
        })
        
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func savePhoto(_ sender: UIBarButtonItem) {
        
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newPhoto = NSEntityDescription.insertNewObject(forEntityName: "ImageDetails", into: context)


           newPhoto.setValue(imagetitle.text, forKey: "title")
            
            do
            {
                try context.save()
            }
            catch {
                tixing(message: "data could not be saved!")
            }
            
    }

}
