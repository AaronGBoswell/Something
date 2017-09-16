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
    do {
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
func newKind(id:Int64, alpha:Float,color:Int64, title:String){
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let kind = NSEntityDescription.insertNewObject(forEntityName: "Kind", into: moc) as! Kind
    kind.id = id
    kind.alpha = alpha
    kind.color = color
    kind.title = title
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
}
func setupKinds(){
    newKind(id: 1,alpha: 0.5,color: 0xff0000,title: "need to do")
    newKind(id: 2,alpha: 0.5,color: 0x00ff00,title: "nice to do")
    newKind(id: 3,alpha: 0.5,color: 0x0000ff,title: "want to do")
    newKind(id: Int64.max ,alpha: 1,color: 0xff0000,title: "Doesn't matter")
    
}
func newTime(id:Int64, alpha:Float,color:Int64, title:String){
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    let time = NSEntityDescription.insertNewObject(forEntityName: "Time", into: moc) as! Time
    time.id = id
    time.alpha = alpha
    time.color = color
    time.title = title
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
}
func setupTimes(){
    newTime(id: 1,alpha: 1, color: 0xff0000, title: "5min")
    newTime(id: 2,alpha: 1, color: 0xff0000, title: "30min")
    newTime(id: 3,alpha: 1, color: 0xff0000, title: "60min")
    newTime(id: Int64.max ,alpha: 1,color: 0xff0000,title: "Doesn't matter")
    
}
