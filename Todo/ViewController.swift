//
//  ViewController.swift
//  Todo
//
//  Created by Petr Grishin on 21.02.15.
//  Copyright (c) 2015 Petr Grishin. All rights reserved.
//


import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var Table: UITableView!

    var todoList = [] as [TodoList]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Table.registerClass(TableViewCell.self, forCellReuseIdentifier: "Cell")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList", name:"load", object: nil)
        loadList()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath index: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: index) as! TableViewCell
        cell.title!.text = todoList[index.row].title
        cell.dateText!.text = todoList[index.row].toDate.description
        cell.controller = self
        return cell
    }

    func getTodoList() -> [TodoList] {
        var todoLists = [] as [TodoList]
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
            let fetchRequest = NSFetchRequest(entityName: "TodoList")
            do {
                todoLists = try managedObjectContext.executeFetchRequest(fetchRequest) as! [TodoList]
            } catch {
                
            }
            
        }
        return todoLists
    }
    
    func removeItem (cell: UITableViewCell) {
        let index = Table.indexPathForCell(cell)!.row
        let record = todoList[index]
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
            managedObjectContext.deleteObject(record)
            try! managedObjectContext.save()
        }
        
        loadList()
    }

    func loadList() {
        todoList = getTodoList()
        Table.reloadData()
    }
}
