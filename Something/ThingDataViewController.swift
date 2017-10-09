//
//  ThingDataViewController.swift
//  Something
//
//  Created by Henry Boswell on 9/16/17.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//

//
//  DoThingViewController.swift
//  Something
//
//  Created by Henry Boswell on 9/12/17.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//
import UIKit
import CoreData


class ThingDataViewController: UIViewController{
    
    var colorView:UIView?
    var getThing:Thing?
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    var thingDataLabel: UILabel?
    var noteDataLabel: UILabel?
	var note: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = StyleModel.sharedInstance.backgroundColor
        
        makeColorView()
        makeDoneButton()
        //makeNoteLabel()
        makeThingDataLabel()
        makeThingNoteDataLabel()
        makeCompletedButton()
        note?.text = getThing?.note
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = getThing?.title
        note?.text = getThing?.note
    }

    @objc func editAction(sender: UIButton!) {
        performSegue(withIdentifier: "ThingDataToTitleRemember", sender: self)
        CreateThingWizard.newFromExisting(thing: getThing!)
        
        let workflowItemOne = WorkFlowItem(attribute: "Time", segueIdentifier: "BacktoAttribute", attributePredicate: NSPredicate(format: "id != \(Int64.max)"), selectAttributeClosure: {attribute in CreateThingWizard.sharedCreateThingWizard.thing.time = (attribute as! Time)}
        )
        let workflowItemTwo = WorkFlowItem(attribute: "Kind", segueIdentifier: "AttributeToNote", attributePredicate: NSPredicate(format: "id != \(Int64.max)"), selectAttributeClosure: {attribute in CreateThingWizard.sharedCreateThingWizard.thing.kind = (attribute as! Kind)}
        )
        Workflow.sharedWorkflow.setWorkflow(workflow: [workflowItemOne, workflowItemTwo])
    }
    
    @objc func completedAction(sender: UIButton!) {
        getThing?.lastCompleted = Date()
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        print("completed")
        self.popBack(5)
    }
    
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
    
    func makeDoneButton(){
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: #selector(editAction)), animated: true)
    }
    
    func makeThingDataLabel(){
        let width = self.view.frame.width
        let label: UILabel = UILabel(frame: CGRect(x: 10, y: 20, width: width - 20, height: 50))
        label.backgroundColor = .clear
        label.textColor = StyleModel.sharedInstance.labelColor
        label.textAlignment = NSTextAlignment.left
        label.text = (getThing?.title)!
        self.view.addSubview(label)
    }
    
    func makeNoteLabel(){
        let width = self.view.frame.width
        let label: UILabel = UILabel(frame: CGRect(x: 10, y: 130, width: width - 20, height: 500))
        label.backgroundColor = .clear
        label.textColor = StyleModel.sharedInstance.labelColor
        label.textAlignment = NSTextAlignment.left
        label.text = (getThing?.note)!
        self.view.addSubview(label)
    }
    
    func makeThingNoteDataLabel(){
        let width = self.view.frame.width
        let height = self.view.frame.height
        note = UITextView(frame: CGRect(x: 20, y: 130, width: width - 40, height: height - 100))
        note!.backgroundColor = .clear
        note!.textColor = StyleModel.sharedInstance.labelColor
        note!.textAlignment = NSTextAlignment.left
        note!.font = UIFont(name: "PingFang SC Thin", size: 20)
        self.view.addSubview(note!)
    }
    
    func makeCompletedButton(){
        let button = UIButton(frame: CGRect(x: 0, y: self.view.frame.size.height - 125, width: self.view.frame.size.width, height: 100))
        button.backgroundColor = .black
        button.setTitle("TASK COMPLETED", for: .normal)
        button.titleLabel?.font = UIFont(name: "PingFang SC Thin", size: 20)
        button.setTitleColor(StyleModel.sharedInstance.homeTextHistoryColor, for: .normal)
        button.addTarget(self, action: #selector(completedAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    func makeColorView(){
        let width = self.view.frame.width
        let height = self.view.frame.height
        colorView  = UIView(frame: CGRect(x: 0, y: 100, width: width, height: height-400))
        colorView?.backgroundColor = UIColor(rgb: Int((getThing!.kind?.color)!))
        self.view.addSubview(colorView!)
    }
}
