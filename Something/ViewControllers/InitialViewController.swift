//
//  ViewController.swift
//  Something
//
//  Created by Aaron Boswell on 2017-09-11.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = StyleModel.sharedInstance.backgroundColor
        makeTitle()
        makeMakeButton()
        madeDoButton()
        makeSomethingButton()
        makeTitleMotto()
    }
    
    
    //trying this on for size going to make it in storyboard
    func makeTitle(){
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 100))
       // label.frame = CGRectMake(50, 50, 200, 21)
        label.backgroundColor = .clear
        label.textColor = StyleModel.sharedInstance.homeTitleColor
        label.textAlignment = NSTextAlignment.center
        label.text = "Something"
        label.font = UIFont(name: "PingFang SC", size: 30)
        self.view.addSubview(label)
    }

    func makeTitleMotto(){
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 175, width: self.view.frame.size.width, height: 220))
        // label.frame = CGRectMake(50, 50, 200, 21)
        label.backgroundColor = .clear
        label.textColor = StyleModel.sharedInstance.buttonColor
        label.textAlignment = NSTextAlignment.center
        label.text = "Organize your thoughts."
        label.font = UIFont(name: "PingFang SC", size: 14)
        self.view.addSubview(label)
    }

    func makeMakeButton(){
        let button = UIButton(frame: CGRect(x: 0, y: 300, width: self.view.frame.size.width, height: 100))
        button.backgroundColor = .black
        button.setTitle("MAKE", for: .normal)
        button.titleLabel?.font = UIFont(name: "PingFang SC Thin", size: 20)
        button.setTitleColor(StyleModel.sharedInstance.homeTextMakeColor , for: .normal)
        button.addTarget(self, action: #selector(makeAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    func madeDoButton(){
        let button = UIButton(frame: CGRect(x: 0, y: 401, width: self.view.frame.size.width, height: 100))
        button.backgroundColor = .black
        button.setTitle("DO", for: .normal)
        button.titleLabel?.font = UIFont(name: "PingFang SC Thin", size: 20)
        button.setTitleColor(StyleModel.sharedInstance.homeTextDoColor , for: .normal)
        button.addTarget(self, action: #selector(doAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    func makeSomethingButton(){
        let button = UIButton(frame: CGRect(x: 0, y: 502, width: self.view.frame.size.width, height: 100))
        button.backgroundColor = .black
        button.setTitle("SOMETHING", for: .normal)
        button.titleLabel?.font = UIFont(name: "PingFang SC Thin", size: 20)
        button.setTitleColor(StyleModel.sharedInstance.homeTextSomethingColor , for: .normal)
        button.addTarget(self, action: #selector(makeAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     func makeAction(sender: UIButton!) {
        CreateThingWizard.new()
        let workflowItemOne = WorkFlowItem(attribute: "Time", segueIdentifier: "BacktoAttribute", attributePredicate: NSPredicate(format: "id != \(Int64.max)"), selectAttributeClosure: {attribute in CreateThingWizard.sharedCreateThingWizard.thing.time = (attribute as! Time)}
        )
        let workflowItemTwo = WorkFlowItem(attribute: "Kind", segueIdentifier: "AttributeToNote", attributePredicate: NSPredicate(format: "id != \(Int64.max)"), selectAttributeClosure: {attribute in CreateThingWizard.sharedCreateThingWizard.thing.kind = (attribute as! Kind)
        }
        )
        Workflow.sharedWorkflow.setWorkflow(workflow: [workflowItemOne, workflowItemTwo])
        self.performSegue(withIdentifier: "MakeSeuge", sender: self)
    }
    
   func doAction(sender: UIButton!) {
        let workflowItemOne = WorkFlowItem(attribute: "Time", segueIdentifier: "BacktoAttribute", selectAttributeClosure: {attribute in PredicateFormulator.sharedPredicateFormulator.time = (attribute as! Time)}
        )
        let workflowItemTwo = WorkFlowItem(attribute: "Kind", segueIdentifier: "AttributeToThing", selectAttributeClosure: {attribute in PredicateFormulator.sharedPredicateFormulator.kind = (attribute as! Kind)
        }
        )
        Workflow.sharedWorkflow.setWorkflow(workflow: [workflowItemOne, workflowItemTwo])
         self.performSegue(withIdentifier: "StartToAttribute", sender: self)
    }
    
    
}

