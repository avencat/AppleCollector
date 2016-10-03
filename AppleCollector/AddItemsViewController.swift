//
//  AddItemsViewController.swift
//  AppleCollector
//
//  Created by Axel Vencatareddy on 03/10/2016.
//  Copyright © 2016 Axel Vencatareddy. All rights reserved.
//

import UIKit

class AddItemsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

  @IBOutlet weak var collectorImageView: UIImageView!
  @IBOutlet weak var imageTitle: UITextField!
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var deleteButton: UIButton!
  
  var imagePicker = UIImagePickerController()
  var collector : Collector? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    
    imagePicker.delegate = self
    
    if collector != nil {
      imageTitle.text = collector?.title
      collectorImageView.image = UIImage(data: collector!.image as! Data)
      addButton.setTitle("Update", for: .normal)
    } else {
      deleteButton.isHidden = true
    }
    
    imageTitle.delegate = self
  }

  @IBAction func cameraTapped(_ sender: AnyObject) {
    imagePicker.sourceType = .camera
    
    present(imagePicker, animated: true, completion: nil)
  }
  
  @IBAction func photosTapped(_ sender: AnyObject) {

    imagePicker.sourceType = .photoLibrary

    present(imagePicker, animated: true, completion: nil)
  }
  
  @IBAction func addTapped(_ sender: AnyObject) {
    
    if collector != nil {
      collector!.title = imageTitle.text
      collector!.image = UIImagePNGRepresentation(collectorImageView.image!) as NSData?
    } else {
      let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
      
      let newCollector = Collector(context: context)
      
      newCollector.title = imageTitle.text
      newCollector.image = UIImagePNGRepresentation(collectorImageView.image!) as NSData?
    }
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
    // Pop the View
    navigationController!.popViewController(animated: true)
  }

  @IBAction func deleteTapped(_ sender: AnyObject) {
    (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext.delete(collector!)
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
    // Pop the View
    navigationController!.popViewController(animated: true)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    let image = info[UIImagePickerControllerOriginalImage] as! UIImage

    collectorImageView.image = image
    
    imagePicker.dismiss(animated: true, completion: nil)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
  }

}
