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
    // End
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


