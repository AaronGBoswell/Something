//
//  CreateThingWizard.swift
//  Something
//
//  Created by Aaron Boswell on 2017-09-11.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//

import UIKit

import Foundation
import CoreData

class CreateThingWizard {
    
    public static var sharedCreateThingWizard = CreateThingWizard()
    
    public class func destroy(){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        moc.delete(sharedCreateThingWizard.thing)
        sharedCreateThingWizard.save()
        sharedCreateThingWizard.thing = nil
    }
        
    public class func new(){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let thing = NSEntityDescription.insertNewObject(forEntityName: "Thing", into: moc) as! Thing
        thing.dateCreated = Date()
        sharedCreateThingWizard.thing = thing
        sharedCreateThingWizard.editing = false

    }

    public class func newFromExisting(thing:Thing){
        sharedCreateThingWizard.thing = thing
        sharedCreateThingWizard.editing = true
    }
    
    public var thing:Thing!
    public var editing = false
    
    public func save(){
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
}
