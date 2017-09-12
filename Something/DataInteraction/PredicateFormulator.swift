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
    public class func new(){
        sharedPredicateFormulator = PredicateFormulator()
    }
    public var kind:Kind?
    public var time:Time?

    public func getPredicate() -> NSPredicate{
        let kindPredicate = kind == nil ? NSPredicate(value: true) : NSPredicate(format: "kind.title contains[cd]", kind!.title!)
        let timePredicate = time == nil ? NSPredicate(value: true) : NSPredicate(format: "time.title contains[cd]", time!.title!)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [kindPredicate, timePredicate])
        return compoundPredicate
    }
}
