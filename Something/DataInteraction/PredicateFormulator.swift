//
//  File.swift
//  Something
//
//  Created by Aaron Boswell on 2017-09-11.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//

import Foundation
import CoreData

class PredicateFormulator {
    
    public static var sharedPredicateFormulator = PredicateFormulator()
    public var kind:Kind?
    public var time:Time?
    public var completed = false

    public func getPredicate() -> NSPredicate{
        let kindPredicate = (kind == nil || kind!.id == Int64.max) ? NSPredicate(value: true) : NSPredicate(format: "kind.title contains[cd] %@", kind!.title!)
        let timePredicate = (time == nil || time!.id == Int64.max) ? NSPredicate(value: true) : NSPredicate(format: "time.title contains[cd] %@", time!.title!)
        let completedPredicate = (completed) ? NSPredicate(format: "lastCompleted != nil") : NSPredicate(format: "lastCompleted == nil")
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [kindPredicate, timePredicate, completedPredicate])
        return compoundPredicate
    }
}
