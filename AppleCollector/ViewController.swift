//
//  ViewController.swift
//  AppleCollector
//
//  Created by Axel Vencatareddy on 02/10/2016.
//  Copyright © 2016 Axel Vencatareddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  
  var products : [Collector] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view, typically from a nib.
    
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return products.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    
    cell.textLabel?.text = products[indexPath.row].title
    cell.imageView?.image = UIImage(data: products[indexPath.row].image as! Data)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "collectorViewSegue", sender: products[indexPath.row])
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destVC = segue.destination as! AddItemsViewController
    
    destVC.collector = sender as? Collector
  }

  override func viewWillAppear(_ animated: Bool) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    do {
      products = try context.fetch(Collector.fetchRequest())
      tableView.reloadData()
    } catch {
      print("An error occured when fetching...")
    }
  }

}

