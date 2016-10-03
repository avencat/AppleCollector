//
//  AddItemsViewController.swift
//  AppleCollector
//
//  Created by Axel Vencatareddy on 03/10/2016.
//  Copyright © 2016 Axel Vencatareddy. All rights reserved.
//

import UIKit

class AddItemsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  @IBOutlet weak var collectorImageView: UIImageView!
  @IBOutlet weak var imageTitle: UITextField!
  
  var imagePicker = UIImagePickerController()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    
    imagePicker.delegate = self
  }

  @IBAction func cameraTapped(_ sender: AnyObject) {
    
  }
  
  @IBAction func photosTapped(_ sender: AnyObject) {

    imagePicker.sourceType = .photoLibrary

    present(imagePicker, animated: true, completion: nil)
  }
  
  @IBAction func addTapped(_ sender: AnyObject) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let collector = Collector(context: context)
    
    collector.title = imageTitle.text
    collector.image = UIImagePNGRepresentation(collectorImageView.image!) as NSData?
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
    // Pop the View
    navigationController!.popViewController(animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    let image = info[UIImagePickerControllerOriginalImage] as! UIImage

    collectorImageView.image = image
    
    imagePicker.dismiss(animated: true, completion: nil)
  }

}
