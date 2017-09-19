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
    
    public class func new(){
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let thing = NSEntityDescription.insertNewObject(forEntityName: "Thing", into: moc) as! Thing
        thing.dateCreated = NSDate()
        sharedCreateThingWizard.thing = thing
    }

    //To use when editing an existing thing
    public class func newFromExisting(thing:Thing){
        sharedCreateThingWizard.thing = thing
    }
    
    public var thing:Thing!
    
    public func save(){
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }


}
