//
//  DetailViewController.swift
//  NowWhat
//
//  Created by Jamie Randall on 3/22/18.
//  Copyright © 2018 Jamie Randall. All rights reserved.
//

import UIKit
import CoreData



class DetailViewController: UIViewController {
  
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var taskLabel: UILabel!
  @IBOutlet weak var taskContent: UITextView!
  
  var items: Tasks?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let item = items {
      
      taskLabel.text = item.title
      taskContent.text = item.content
      dateLabel.text = item.date
      
    } else {
      
      taskLabel.text = ""
      taskContent.text = ""
      dateLabel.text = ""
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
    navigationItem.leftItemsSupplementBackButton = true
    
    if let detailItem = self.items {
      navigationItem.title = detailItem.title
      taskLabel.text = detailItem.content
      dateLabel.text = detailItem.date
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let masterViewController = segue.destination as! MasterViewController
    
    if let identifier = segue.identifier {
      if identifier == "Done" {
        print("Done button tapped")
        
        if let task = items {
          
          task.title = taskLabel.text ?? ""
          task.content = taskContent.text ?? ""
          task.date = dateLabel.text ?? ""
          masterViewController.tableView.reloadData()
          
        } else {
          
          let task = self.items ?? CoreData.newTask()
          task.title = taskLabel.text ?? ""
          task.content = taskContent.text ?? ""
          task.date = dateLabel.text ?? ""
          CoreData.saveTask()
        }
      }
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}
