//
//  CoreData.swift
//  NowWhat
//
//  Created by Jamie Randall on 3/22/18.
//  Copyright © 2018 Jamie Randall. All rights reserved.
//
import CoreData
import UIKit

class CoreData {
  static let appDelegate = UIApplication.shared.delegate as! AppDelegate
  static let persistentContainer = appDelegate.persistentContainer
  static let managedContext = persistentContainer.viewContext
  
  static func newTask() -> Tasks {
    let task = NSEntityDescription.insertNewObject(forEntityName: "Tasks", into: managedContext) as! Tasks
    return task
  }
  
  static func saveTask() {
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Could not save \(error)")
    }
  }
  
  static func delete(task: Tasks) {
    managedContext.delete(task)
    saveTask()
  }
  
  static func retrieveTasks() -> [Tasks] {
    let fetchRequest = NSFetchRequest<Tasks>(entityName: "Tasks")
    do {
      let results = try managedContext.fetch(fetchRequest)
      return results
    } catch let error as NSError {
      print("Could not fetch \(error)")
    }
    return []
  }
  
  static func updateTasks() {
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Could not save \(error)")
    }
  }
}
