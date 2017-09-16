//
//  ViewController.swift
//  Something
//
//  Created by Aaron Boswell on 2017-09-11.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor(rgb:0x69D300)
        makeTitle()
    }
    
    
    //trying this on for size going to make it in storyboard
    func makeTitle(){
        let label: UILabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
       // label.frame = CGRectMake(50, 50, 200, 21)
        label.backgroundColor = .clear
        label.textColor = UIColor(rgb:0x50514F)
        label.textAlignment = NSTextAlignment.center
        label.text = "SOMTHING"
        self.view.addSubview(label)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func MakeButton(_ sender: Any) {
        CreateThingWizard.new()
        let workflowItemOne = WorkFlowItem(attribute: "Time", segueIdentifier: "BacktoAttribute", attributePredicate: NSPredicate(format: "id != \(Int64.max)"), selectAttributeClosure: {attribute in CreateThingWizard.sharedCreateThingWizard.thing.time = (attribute as! Time)}
        )
        let workflowItemTwo = WorkFlowItem(attribute: "Kind", segueIdentifier: "AttributeToNote", attributePredicate: NSPredicate(format: "id != \(Int64.max)"), selectAttributeClosure: {attribute in CreateThingWizard.sharedCreateThingWizard.thing.kind = (attribute as! Kind)
        }
        )
        Workflow.sharedWorkflow.setWorkflow(workflow: [workflowItemOne, workflowItemTwo])
        self.performSegue(withIdentifier: "MakeSeuge", sender: self)
    }
    
    @IBAction func DoButton(_ sender: Any) {
        let workflowItemOne = WorkFlowItem(attribute: "Time", segueIdentifier: "BacktoAttribute", selectAttributeClosure: {attribute in PredicateFormulator.sharedPredicateFormulator.time = (attribute as! Time)}
        )
        let workflowItemTwo = WorkFlowItem(attribute: "Kind", segueIdentifier: "AttributeToThing", selectAttributeClosure: {attribute in PredicateFormulator.sharedPredicateFormulator.kind = (attribute as! Kind)
        }
        )
        Workflow.sharedWorkflow.setWorkflow(workflow: [workflowItemOne, workflowItemTwo])
         self.performSegue(withIdentifier: "StartToAttribute", sender: self)
    }
    
    
}

protocol Attribute {
    var alpha:Float {get set};
    var color:Int64 {get set};
    var icon:NSData? {get set};
    var id:Int64 {get set};
    var title:String?{get set};
}
extension Time:Attribute{
    
}
extension Kind:Attribute{
    
}
