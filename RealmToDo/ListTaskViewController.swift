//
//  ViewController.swift
//  RealmToDo
//
//  Created by Soto Yanis on 08/06/2016.
//  Copyright © 2016 Soto Yanis. All rights reserved.
//

import UIKit
import RealmSwift

class ListTaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    var taskList = [TaskList]()
    var taskList : Results<TaskList>!
    
    @IBOutlet var taskListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        readTasksAndUpdateUI()
    }

    //MARK: - @IBAction -
    @IBAction func addAction(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add", message: "Enter your name list", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = "Enter your text"
        })
        alert.addAction(UIAlertAction(title: "Save", style: .Default, handler: { (action) -> Void in
            guard case let textField = alert.textFields![0] as UITextField where textField.text!.trim() != "" else {
                let alertError = showAlertWithTitle("Error", message: "Name can't be Blank")
                self.presentViewController(alertError, animated: true, completion: nil)
                return
            }
            let newList = TaskList()
            newList.name = textField.text!
            do { try uiRealm.write() {
                    uiRealm.add(newList)
                self.readTasksAndUpdateUI()
                }
            } catch {
                print("Can't add the list")
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action) -> Void in
            print("Cancel pressed")
        }))
        alert.view.setNeedsLayout()
        self.presentViewController(alert, animated: true, completion: nil)
        self.readTasksAndUpdateUI()
    }
    // End
    
    // MARK: - Get & Update Realm object
    func readTasksAndUpdateUI(){
        taskList = uiRealm.objects(TaskList)
        //self.taskListsTableView.setEditing(false, animated: true)
        self.taskListTableView.reloadData()
    }
    // - End -
    
    //MARK: - UITableViewDataSource -
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return taskList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath) as! CellListTaskTableViewCell
        cell.nameLabel.text = taskList![indexPath.row].name
        cell.countTask.text = "\(taskList![indexPath.row].tasks.count) Tasks"
        return (cell)
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Delete") { (deleteAction, indexPath) -> Void in
            
            let listToBeDeleted = self.taskList[indexPath.row]
            do { try uiRealm.write() {
                uiRealm.delete(listToBeDeleted)
                self.readTasksAndUpdateUI()
                }
            } catch {
                print("Can't delete the list")
            }
        }
        
       
       /* let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Edit") { (editAction, indexPath) -> Void in
            
            //let listToBeUpdated = self.taskList[indexPath.row]
            self.readTasksAndUpdateUI()
            
        }*/
        return [deleteAction]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("taskSegue", sender: self.taskList[indexPath.row])
    }
    // End
    
    //MARK: - Segue -
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let tasksViewController = segue.destinationViewController as! TaksViewController
        tasksViewController.selectedList = sender as! TaskList

    }
    
    //END
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}