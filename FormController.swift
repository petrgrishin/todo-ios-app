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
    @IBOutlet weak var toDateField: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTodo() {
        let text = textField.text
        let date = toDateField.date
        
        guard  text != "" else {
            return
        }
        
        guard let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext else {
            return
        }
        
        let todo:TodoList! = NSEntityDescription.insertNewObjectForEntityForName("TodoList", inManagedObjectContext: managedObjectContext) as! TodoList
        todo.title = text
        todo.toDate = date
            
            
//            var e: NSError?
        do {
            try managedObjectContext.save()
        } catch {
        }
            
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        
        self.navigationController?.popViewControllerAnimated(true)

    }
}