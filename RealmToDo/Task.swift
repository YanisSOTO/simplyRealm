//
//  Task.swift
//  RealmToDo
//
//  Created by Soto Yanis on 08/06/2016.
//  Copyright © 2016 Soto Yanis. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    
    dynamic var name = ""
    dynamic var createdAt = NSDate()
    dynamic var notes = ""
    dynamic var isCompleted = false

// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
