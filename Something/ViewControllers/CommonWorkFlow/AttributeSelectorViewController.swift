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
    
    
    var attribute = Workflow.sharedWorkflow.getCurrentWorkFlowItem().attribute
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    var canSegue = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(rgb:0x69D300)
        
        
        makeKindTableView.delegate = self
        makeKindTableView.dataSource = self
        initalizeFetchedResultsController()
        
        makeBackButton()
         makeTitle()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func makeTitle(){
        let label: UILabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
        // label.frame = CGRectMake(50, 50, 200, 21)
        label.backgroundColor = .clear
        label.textColor = UIColor(rgb:0x50514F)
        label.textAlignment = NSTextAlignment.center
        label.text = attribute
        self.view.addSubview(label)
    }
    
    func makeBackButton(){
        let button = UIButton(frame: CGRect(x: 10, y: 20, width: 100, height: 50))
        button.backgroundColor = .clear
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor(rgb:0x50514F), for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    func backAction(sender: UIButton!) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
 

    //TableView 
    @IBOutlet weak var makeKindTableView: UITableView!
    
    
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
        guard let selectedAttribute = fetchedResultsController.object(at: indexPath) as? Attribute
            else{
                fatalError("Failed to initialize ")
        }
        cell.initialize(color: UIColor(rgb: Int(selectedAttribute.color), a: CGFloat(selectedAttribute.alpha)), data: selectedAttribute.title!)
        //cell.initialize(color: .green, data: selectedKind.title!)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let selectedAttribute = fetchedResultsController.object(at: indexPath) as? Attribute
            else{
                fatalError("Failed to initialize ")
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        Workflow.sharedWorkflow.getCurrentWorkFlowItem().selectAttribute(attribute: selectedAttribute)
        let segueIdentifier = Workflow.sharedWorkflow.getCurrentWorkFlowItem().segueIdentifier
        
        Workflow.sharedWorkflow.nextWorkFlowItem()
        performSegue(withIdentifier: segueIdentifier, sender: self)
        
        
    }
    
    //This is to not perform a segue that is executed by clicking on the cell via storyboard
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let s = sender as? AttributeTableViewCell{
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
            print(fetchedResultsController.fetchedObjects ?? "default value")
        }catch{
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
        
        
    }

    
    
}

extension AttributeSelectorViewController:NSFetchedResultsControllerDelegate{
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        makeKindTableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            makeKindTableView.insertSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)
        case .delete:
            makeKindTableView.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)
        case .move:
            break
        case .update:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            makeKindTableView.insertRows(at: [newIndexPath! as IndexPath], with: .fade)
        case .delete:
            makeKindTableView.deleteRows(at: [indexPath! as IndexPath], with: .fade)
        case .update:
             break;
            //configureCell(cell: makeKindTableView.cellForRow(at: indexPath! as IndexPath)!, indexPath: indexPath! as IndexPath)
           
        case .move:
            makeKindTableView.reloadData()
            
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        makeKindTableView.endUpdates()
    }
}

