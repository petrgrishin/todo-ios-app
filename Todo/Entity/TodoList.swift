//
// Created by Petr Grishin on 21.02.15.
// Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

import Foundation
import CoreData

class TodoList: NSManagedObject {
    @NSManaged var title: String!
    @NSManaged var toDate: NSDate!
}
