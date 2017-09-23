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
        
        MakeColorView()
        MakeDoneButton()
        MakeNoteLabel()
        MakeThingDataLabel()
        MakeThingNoteDataLabel()
        note?.text = getThing?.note

        
        
        // Do any additional setup after loading the view, typically from a nib.
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
        let workflowItemTwo = WorkFlowItem(attribute: "Kind", segueIdentifier: "AttributeToNote", attributePredicate: NSPredicate(format: "id != \(Int64.max)"), selectAttributeClosure: {attribute in CreateThingWizard.sharedCreateThingWizard.thing.kind = (attribute as! Kind)
        }
        )
        Workflow.sharedWorkflow.setWorkflow(workflow: [workflowItemOne, workflowItemTwo])
    }
    func MakeDoneButton(){
    
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: #selector(editAction)), animated: true)
            //self.view.addSubview(button)
    }
    
    func MakeThingDataLabel(){
        let width = self.view.frame.width
        let label: UILabel = UILabel(frame: CGRect(x: 10, y: 20, width: width - 20, height: 50))
        // label.frame = CGRectDo(50, 50, 200, 21)
        label.backgroundColor = .clear
        label.textColor = StyleModel.sharedInstance.labelColor
        label.textAlignment = NSTextAlignment.left
        label.text = "Task: " + (getThing?.title)!
        self.view.addSubview(label)
    }
    func MakeNoteLabel(){
        let width = self.view.frame.width
        let label: UILabel = UILabel(frame: CGRect(x: 10, y: 70, width: width - 20, height: 50))
        // label.frame = CGRectDo(50, 50, 200, 21)
        label.backgroundColor = .clear
        label.textColor = StyleModel.sharedInstance.labelColor
        label.textAlignment = NSTextAlignment.left
        label.text = "Note: "
        self.view.addSubview(label)
    }
    
    func MakeThingNoteDataLabel(){
        let width = self.view.frame.width
        let height = self.view.frame.height
        note = UITextView(frame: CGRect(x: 20, y: 100, width: width - 40, height: height - 100))
        // label.frame = CGRectDo(50, 50, 200, 21)
        note!.backgroundColor = .clear
        note!.textColor = StyleModel.sharedInstance.labelColor
        note!.textAlignment = NSTextAlignment.center
        self.view.addSubview(note!)
    }
    
    
    func MakeColorView(){
        let width = self.view.frame.width
        let height = self.view.frame.height
        colorView  = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        colorView?.backgroundColor = UIColor(rgb: Int((getThing!.kind?.color)!))
        self.view.addSubview(colorView!)
        
        
    }

   
    
    
}

