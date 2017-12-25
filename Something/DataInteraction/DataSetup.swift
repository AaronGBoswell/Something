//
//  DataSetup.swift
//  Something
//
//  Created by Aaron Boswell on 2017-09-16.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//

//***************************
//Ultra global
//Demons attend ye henceforth
//***************************
import Foundation
import UIKit
import CoreData

func purgeCoreData(){
    purge(entityName: "Thing")
    purge(entityName: "Time")
    purge(entityName: "Kind")
    
}

func purge(entityName:String){
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let venueFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName )
    do{
        let fetched = try moc.fetch(venueFetch) as! [NSManagedObject]
        fetched.forEach({moc.delete($0)})
        
    } catch {
        print("Something went wrong.\n")
    }
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
}
func setupCoreData(){
    setupKinds()
    setupTimes()
}

func newKind(id:Int64, alpha:Float,color:Int64, title:String, icon:UIImage){
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let kind = NSEntityDescription.insertNewObject(forEntityName: "Kind", into: moc) as! Kind
    kind.id = id
    kind.alpha = alpha
    kind.color = color
    kind.title = title
    kind.icon = UIImagePNGRepresentation(icon)
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
}

func setupKinds(){
    newKind(id: 1,alpha: 1,color: Int64(StyleModel.sharedInstance.kindColors["Need to do."]!),title: "Need to do.", icon:  StyleModel.sharedInstance.imageNamesKind["Need to do."]!)
    newKind(id: 2,alpha: 1,color: Int64(StyleModel.sharedInstance.kindColors["Nice to do."]!),title: "Nice to do.", icon:  StyleModel.sharedInstance.imageNamesKind["Nice to do."]!)
    newKind(id: 3,alpha: 1,color: Int64(StyleModel.sharedInstance.kindColors["Want to do."]!),title: "Want to do.", icon:  StyleModel.sharedInstance.imageNamesKind["Want to do."]!)
    newKind(id: Int64.max ,alpha: 1,color: Int64(StyleModel.sharedInstance.kindColors["Doesn't matter."]!),title: "Doesn't matter", icon:  StyleModel.sharedInstance.imageNamesKind["Doesn't matter."]!)
}

func newTime(id:Int64, alpha:Float,color:Int64, title:String,  icon:UIImage){
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let time = NSEntityDescription.insertNewObject(forEntityName: "Time", into: moc) as! Time
    time.id = id
    time.alpha = alpha
    time.color = color
    time.title = title
     time.icon = UIImagePNGRepresentation(icon)
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
}

func setupTimes(){
    newTime(id: 1,alpha: 1, color:  Int64(StyleModel.sharedInstance.timeColors["5min"]!), title: "Short", icon:  StyleModel.sharedInstance.imageNamesTime["5min"]!)
    newTime(id: 2,alpha: 1, color:  Int64(StyleModel.sharedInstance.timeColors["30min"]!), title: "Medium", icon:  StyleModel.sharedInstance.imageNamesTime["30min"]!)
    newTime(id: 3,alpha: 1, color:  Int64(StyleModel.sharedInstance.timeColors["55min"]!), title: "Long", icon:  StyleModel.sharedInstance.imageNamesTime["55min"]!)
    newTime(id: Int64.max ,alpha: 1,color:  Int64(StyleModel.sharedInstance.timeColors["Doesn't matter."]!),title: "Doesn't matter", icon:  StyleModel.sharedInstance.imageNamesTime["Doesn't matter."]!)
    
}
