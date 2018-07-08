//
//  MasterViewController.swift
//  NowWhat
//
//  Created by Jamie Randall on 3/22/18.
//  Copyright © 2018 Jamie Randall. All rights reserved.
//

import UIKit
import CoreData 

class MasterViewController: UITableViewController, UISplitViewControllerDelegate {
  
  struct Storyboard {
    static let mainStoryboard = "Main"
    static let addTaskViewController = "AddTaskViewController"
  }
  
  var items = [Tasks]() {
    didSet {
      tableView.reloadData()
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.leftBarButtonItem = editButtonItem
    tableView.tableFooterView = UIView()
    items = CoreData.retrieveTasks()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return items.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
    
    let row = indexPath.row
    let item = items[row]
    
    cell.taskTitleLabel.text = item.title  
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      
      CoreData.delete(task: items[indexPath.row])
      items = CoreData.retrieveTasks()
    }
  }
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated:  animated)
    
    if editing {
      tableView.setEditing(true, animated: true)
    } else {
      tableView.setEditing(false, animated: true)
    }
  }
  
  func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    
    let item = items[sourceIndexPath.row]
    items.remove(at: sourceIndexPath.row)
    items.insert(item, at: destinationIndexPath.row)
    
    self.items = CoreData.retrieveTasks()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let identifier = segue.identifier {
      
      if identifier == "ShowDetail" {
        print("Table view cell tapped")
        if let indexPath = self.tableView.indexPathForSelectedRow {
          
          let item = items[indexPath.row]
          let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
          controller.items = item
          
        }
      }
    }
  }
  
  @IBAction func unwindToMasterViewController(_ segue: UIStoryboardSegue) {
    self.items = CoreData.retrieveTasks()
  }
}

extension MasterViewController: UIPopoverPresentationControllerDelegate {
  @IBAction func addTask(_ sender: UIBarButtonItem) {
    let storyboard: UIStoryboard = UIStoryboard(name: Storyboard.mainStoryboard, bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: Storyboard.addTaskViewController)
    viewController.modalPresentationStyle = .popover
    let popover: UIPopoverPresentationController = viewController.popoverPresentationController!
    popover.barButtonItem = sender
    popover.delegate = self
    present(viewController, animated: true, completion: nil)
  }
  
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
    return .fullScreen
  }
}



