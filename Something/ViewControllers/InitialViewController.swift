//
//  ViewController.swift
//  Something
//
//  Created by Aaron Boswell on 2017-09-11.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//

import UIKit
import CoreData

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.view.backgroundColor = StyleModel.sharedInstance.backgroundColor
        //makeTitle()
        makeMakeButton()
        madeDoButton()
        makeSomethingButton()
        makeTitleMotto()
        beautifyNavigationBar()
    }
    func beautifyNavigationBar(){
        let navBar = self.navigationController!.navigationBar
        navBar.isTranslucent = false
        //navBar.tintColor = StyleModel.sharedInstance.backgroundColor
        //navBar.backgroundColor = StyleModel.sharedInstance.backgroundColor
        navBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)

        navBar.shadowImage = UIImage()
        self.title = "Something"

        
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
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100))
        // label.frame = CGRectMake(50, 50, 200, 21)
        label.backgroundColor = .clear
        label.textColor = StyleModel.sharedInstance.buttonColor
        label.textAlignment = NSTextAlignment.center
        label.text = "Organize your thoughts."
        label.font = UIFont(name: "PingFang SC", size: 14)
        self.view.addSubview(label)
    }

    func makeMakeButton(){
        let button = UIButton(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 100))
        button.backgroundColor = .black
        button.setTitle("MAKE", for: .normal)
        button.titleLabel?.font = UIFont(name: "PingFang SC Thin", size: 20)
        button.setTitleColor(StyleModel.sharedInstance.homeTextMakeColor , for: .normal)
        button.addTarget(self, action: #selector(makeAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    func madeDoButton(){
        let button = UIButton(frame: CGRect(x: 0, y: 201, width: self.view.frame.size.width, height: 100))
        button.backgroundColor = .black
        button.setTitle("DO", for: .normal)
        button.titleLabel?.font = UIFont(name: "PingFang SC Thin", size: 20)
        button.setTitleColor(StyleModel.sharedInstance.homeTextDoColor , for: .normal)
        button.addTarget(self, action: #selector(doAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    func makeSomethingButton(){
        let button = UIButton(frame: CGRect(x: 0, y: 302, width: self.view.frame.size.width, height: 100))
        button.backgroundColor = .black
        button.setTitle("SOMETHING", for: .normal)
        button.titleLabel?.font = UIFont(name: "PingFang SC Thin", size: 20)
        button.setTitleColor(StyleModel.sharedInstance.homeTextSomethingColor , for: .normal)
        button.addTarget(self, action: #selector(somethingAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InitialToThing" {
            
            let nextView = segue.destination as! ThingDataViewController
            let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Thing")
            request.predicate = NSPredicate(format: "lastCompleted == nil")
            do{
                let results = try moc.fetch(request)as! [Thing]
                let randomIndex = Int(arc4random_uniform(UInt32(results.count)))
                print(randomIndex)
                print(results)
                nextView.getThing = results[randomIndex]
            }catch{
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            
        }
        
        
    }
    func somethingAction(sender: UIButton!) {
        performSegue(withIdentifier: "InitialToThing", sender: self)
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

//This sets the height of the NavBar

extension UINavigationBar{
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        var rec = self.frame
        let screenRect = UIScreen.main.bounds
        rec.size.width = screenRect.size.width
        rec.size.height = 150
        
        return rec.size
    }
}

