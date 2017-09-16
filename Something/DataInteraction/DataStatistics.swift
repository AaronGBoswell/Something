//
//  AttributeStatistics.swift
//  Something
//
//  Created by Aaron Boswell on 2017-09-16.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct DataStatistics{
    var kind:Kind?
    var time:Time?
    
    func dataStatisticsWithAttibute(attribute:Attribute) -> DataStatistics!{
        if let kind = attribute as? Kind{
            var newDataStatistics = self
            newDataStatistics.kind = kind
            return newDataStatistics
        }
        if let time = attribute as? Time{
            var newDataStatistics = self
            newDataStatistics.time = time
            return newDataStatistics
        }
        return nil
    }
    
    func calculateTotal() -> Int{
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let predicateFormulator = PredicateFormulator()
            predicateFormulator.kind = kind
            predicateFormulator.time = time
            let request:NSFetchRequest<Thing> = Thing.fetchRequest()
            request.predicate = predicateFormulator.getPredicate()
            let results = try moc.fetch(request)
            return results.count
        }
        catch {
            print ("fetch task failed", error)
        }
        return -1
    }
}
