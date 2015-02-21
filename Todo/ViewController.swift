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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: index) as UITableViewCell
        cell.textLabel?.text = todoList[index.row].title
        cell.detailTextLabel?.text = todoList[index.row].toDate.description
        return cell
    }

    func getTodoList() -> [TodoList] {
        var todoLists = [] as [TodoList]
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext {
            let fetchRequest = NSFetchRequest(entityName: "TodoList")
            var e: NSError?
            todoLists = managedObjectContext.executeFetchRequest(fetchRequest, error: &e) as [TodoList]
        }
        return todoLists
    }

    func loadList() {
        todoList = getTodoList()
        Table.reloadData()
    }
}
