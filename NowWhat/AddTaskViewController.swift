//
//  AddNoteViewController.swift
//  NowWhat
//
//  Created by Jamie Randall on 3/22/18.
//  Copyright © 2018 Jamie Randall. All rights reserved.
//

import UIKit
import CoreData


class AddTaskViewController: UIViewController {
  
  var items: Tasks?
  
  @IBOutlet weak var newTaskTextField: UITextField!
  @IBOutlet weak var newTaskTextView: UITextView!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    newTaskTextField.text = ""
    newTaskTextView.text = ""
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let masterViewController = segue.destination as! MasterViewController
    
    if let identifier = segue.identifier {
      if identifier == "Save" {
        print("Save button tapped")
        
        // Save New Note to Core Data
        
        let task = self.items ?? CoreData.newTask()
        task.title = newTaskTextField.text ?? ""
        task.content = newTaskTextView.text ?? ""
        masterViewController.items.append(task)
        
        CoreData.saveTask()
        
      }
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}
