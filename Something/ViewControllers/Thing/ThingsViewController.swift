//
//  DoThingViewController.swift
//  Something
//
//  Created by Henry Boswell on 9/12/17.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//
import UIKit
import CoreData

class ThingsViewController: UIViewController ,  UITableViewDataSource, UITableViewDelegate {
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    var sendThing:Thing?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = StyleModel.sharedInstance.backgroundColor
        
        thingTableView.delegate = self
        thingTableView.dataSource = self
        initalizeFetchedResultsController()
        
        self.title = "Things"
    }
    
    @objc func backAction(sender: UIButton!) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }

    //TableView
    @IBOutlet weak var thingTableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThingTableViewCell", for: indexPath) as! ThingTableViewCell
        configureCell(cell: cell, indexPath: indexPath)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
        
    }
    func configureCell(cell: ThingTableViewCell, indexPath: IndexPath) {
        guard let selectedThing = fetchedResultsController.object(at: indexPath) as? Thing
            else{
                fatalError("Failed to initialize ")
        }
        cell.initialize(data: selectedThing)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        print("here")
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            //TODO: edit the row at indexPath here
        }
        editAction.backgroundColor = .blue
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
            //TODO: Delete the row at indexPath here
        }
        deleteAction.backgroundColor = .red
        
        return [editAction,deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if let value = tableView.indexPathsForSelectedRows?.contains(indexPath){
            if value == true{
                return UITableViewCellEditingStyle.delete
            }
        }
        return UITableViewCellEditingStyle.none
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedThing = fetchedResultsController.object(at: indexPath) as? Thing
            else{
                fatalError("Failed to initialize ")
        }
    
        //tableView.deselectRow(at: indexPath, animated: true)
        
        sendThing = selectedThing
        //performSegue(withIdentifier: "thingData", sender: tableView.cellForRow(at: indexPath))
        let cell = tableView.cellForRow(at: indexPath) as! ThingTableViewCell
        tableView.setEditing(true, animated: true)
        print("here twii")
        cell.setEditing(true, animated: true)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "thingData" {
            let nextView = segue.destination as! ThingDataViewController
            
            nextView.getThing = sendThing
        }
    }

    func popBack(_ nb: Int) {
        var viewControllers = navigationController?.viewControllers
        viewControllers?.removeLast(nb) // views to pop
        navigationController?.setViewControllers(viewControllers!, animated: true)
    }
    
    func initalizeFetchedResultsController(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Thing")
        let sort = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sort]
        
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        fetchedResultsController.fetchRequest.predicate = PredicateFormulator.sharedPredicateFormulator.getPredicate()
        
        do{
            try fetchedResultsController.performFetch()
            print(fetchedResultsController.fetchedObjects ?? "default value")
        }catch{
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
}

extension ThingsViewController:NSFetchedResultsControllerDelegate{
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        thingTableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            thingTableView.insertSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)
        case .delete:
            thingTableView.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)
        case .move:
            break
        case .update:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            thingTableView.insertRows(at: [newIndexPath! as IndexPath], with: .fade)
        case .delete:
            thingTableView.deleteRows(at: [indexPath! as IndexPath], with: .fade)
        case .update:
            configureCell(cell: thingTableView.cellForRow(at: indexPath! as IndexPath)! as! ThingTableViewCell, indexPath: indexPath! as IndexPath)
        case .move:
            thingTableView.reloadData()
            
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        thingTableView.endUpdates()
    }
}

