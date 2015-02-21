//
//  ViewController.swift
//  Todo
//
//  Created by Petr Grishin on 21.02.15.
//  Copyright (c) 2015 Petr Grishin. All rights reserved.
//


import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var todoList = [["title": "One todo", "toDate": "2014-01-01"], ["title": "Two todo", "toDate": "2015-01-01"]]

    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    }


    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath index: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: index) as UITableViewCell
        cell.textLabel?.text = todoList[index.row]["title"]
        cell.detailTextLabel?.text = todoList[index.row]["toDate"];
        return cell
    }

}
