//
//  FormController.swift
//  Todo
//
//  Created by Juriy Panasevich on 21.02.15.
//  Copyright (c) 2015 Juriy Panasevich. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class FormController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTodo() {
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext {
            var todo:TodoList!
            todo = NSEntityDescription.insertNewObjectForEntityForName("TodoList", inManagedObjectContext: managedObjectContext) as TodoList
            todo.title = textField.text
            todo.toDate = NSDate()
            
            var e: NSError?
            managedObjectContext.save(&e)

            NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)

            self.navigationController?.popViewControllerAnimated(true)
        }
    }
}