//
//  MakeHomeViewController.swift
//  Something
//
//  Created by Henry Boswell on 9/12/17.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//
import UIKit
import CoreData

class AttributeSelectorViewController: UIViewController ,  UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var attribute = Workflow.sharedWorkflow.getCurrentWorkFlowItem().attribute
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    var canSegue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = StyleModel.sharedInstance.backgroundColor
        
        attributeKindTableView.delegate = self
        attributeKindTableView.dataSource = self
        initalizeFetchedResultsController()
        
        title = attribute
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Workflow.sharedWorkflow.removeFromStats(attribute);
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if( self.navigationController?.viewControllers.index(of: self) == nil){
            Workflow.sharedWorkflow.decrementWorkflow()
        }
        super.viewWillDisappear(animated)
    }

    @objc func backAction(sender: UIButton!) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    //TableView 
    @IBOutlet weak var attributeKindTableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AttributeTableViewCell", for: indexPath) as! AttributeTableViewCell
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
    func configureCell(cell: AttributeTableViewCell, indexPath: IndexPath) {
        guard let attributeInCell = fetchedResultsController.object(at: indexPath) as? Attribute
            else{
                fatalError("Failed to initialize ")
        }
        let statString =  String(Workflow.sharedWorkflow.getCurrentDataStatistics().dataStatisticsWith(attribute: attributeInCell).calculateTotal())
       
        cell.initialize(color: UIColor(rgb: Int(attributeInCell.color), a: CGFloat(attributeInCell.alpha)), data: attributeInCell.title!, stat: statString, imageForCell: UIImage(data: attributeInCell.icon! as Data)!)
        cell.accessoryType = UITableViewCellAccessoryType.none
        if CreateThingWizard.sharedCreateThingWizard.editing{
            if CreateThingWizard.sharedCreateThingWizard.thing.kind != nil{
                if attributeInCell as? Kind == CreateThingWizard.sharedCreateThingWizard.thing.kind{
                    cell.accessoryType = UITableViewCellAccessoryType.checkmark
                }
            }
            if CreateThingWizard.sharedCreateThingWizard.thing.time != nil{
                if attributeInCell as? Time == CreateThingWizard.sharedCreateThingWizard.thing.time{
                    cell.accessoryType = UITableViewCellAccessoryType.checkmark
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let selectedAttribute = fetchedResultsController.object(at: indexPath) as? Attribute
            else{
                fatalError("Failed to initialize ")
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        Workflow.sharedWorkflow.getCurrentWorkFlowItem().selectAttribute(attribute: selectedAttribute)
        Workflow.sharedWorkflow.addToStats(attribute: selectedAttribute)
        let segueIdentifier = Workflow.sharedWorkflow.getCurrentWorkFlowItem().segueIdentifier
        Workflow.sharedWorkflow.incrementWorkflow()
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    //This is to not perform a segue that is executed by clicking on the cell via storyboard
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if sender is AttributeTableViewCell {
            return false
        }
        return true
    }

    func initalizeFetchedResultsController(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: attribute)
        let sort = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sort]
        
        let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        fetchedResultsController.fetchRequest.predicate = Workflow.sharedWorkflow.getCurrentWorkFlowItem().attributePredicate

        do{
            try fetchedResultsController.performFetch()
        }catch{
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
}

extension AttributeSelectorViewController:NSFetchedResultsControllerDelegate{
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        attributeKindTableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            attributeKindTableView.insertSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)
        case .delete:
            attributeKindTableView.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)
        case .move:
            break
        case .update:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            attributeKindTableView.insertRows(at: [newIndexPath! as IndexPath], with: .fade)
        case .delete:
            attributeKindTableView.deleteRows(at: [indexPath! as IndexPath], with: .fade)
        case .update:
             break;
        case .move:
            attributeKindTableView.reloadData()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        attributeKindTableView.endUpdates()
    }
}
