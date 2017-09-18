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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = StyleModel.sharedInstance.backgroundColor
        
        
        thingTableView.delegate = self
        thingTableView.dataSource = self
        initalizeFetchedResultsController()
        
        MakeBackButton()
        MakeTitle()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func MakeTitle(){
        let label: UILabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
        // label.frame = CGRectDo(50, 50, 200, 21)
        label.backgroundColor = .clear
        label.textColor = UIColor(rgb:0x50514F)
        label.textAlignment = NSTextAlignment.center
        label.text = "Thing"
        self.view.addSubview(label)
    }
    
    func MakeBackButton(){
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
        //cell.initialize(color: UIColor(rgb: Int((selectedThing.kind?.color)!), a: CGFloat((selectedThing.kind?.alpha)!)), data: selectedThing.title!)
        cell.textLabel?.text = selectedThing.title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //TODO this should bring you to a detaile view of the Thing
        guard let selectedThing = fetchedResultsController.object(at: indexPath) as? Thing
            else{
                fatalError("Failed to initialize ")
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        //TODO
        //CreateThingWizard.sharedInstance.
        
        performSegue(withIdentifier: "thingData", sender: tableView.cellForRow(at: indexPath))
        //self.popBack(3)

        
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
        
        //TODO FYI henry, delete after viewing
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

