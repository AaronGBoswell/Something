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
    
    var makeButton:UIButton?
    var doButton:UIButton?
    var somethingButton:UIButton?
    var historyButton:UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = StyleModel.sharedInstance.backgroundColor
        makeMakeButton()
        madeDoButton()
        makeSomethingButton()
        makeTitleMotto()
        beautifyNavigationBar()
        //makeHistoryButton()
        
        buttonMagic()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        buttonMagic()
    }
    
    func buttonMagic(){
        let data = DataStatistics()
        
        var test = data.dataStatisticsWithCompletion(completed: true)
        var get = test?.calculateTotal()
        /*
        if(get == 0){
            historyButton!.isEnabled = false
        }else{
            historyButton!.isEnabled = true
        }
        */
        test = data.dataStatisticsWithCompletion(completed: false)
        get = test?.calculateTotal()
        
        if(get == 0){
            doButton!.isEnabled = false
            somethingButton!.isEnabled = false
        }else{
            doButton!.isEnabled = true
            somethingButton!.isEnabled = true
        }
    }
    
    func beautifyNavigationBar(){
        let navBar = self.navigationController!.navigationBar
        navBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        if #available(iOS 11.0, *) {
            navBar.prefersLargeTitles = true
        }
        navBar.shadowImage = UIImage()
        self.title = "Something"
    }

    func makeTitleMotto(){
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        // label.frame = CGRectMake(50, 50, 200, 21)
        label.backgroundColor = .clear
        label.textColor = StyleModel.sharedInstance.buttonColor
        label.textAlignment = NSTextAlignment.center
        label.text = "Organize your thoughts."
        label.font = UIFont(name: "PingFang SC", size: 14)
        self.view.addSubview(label)
    }

    func makeMakeButton(){
        makeButton = UIButton(frame: CGRect(x: 0, y: 250, width: self.view.frame.size.width, height: 100))
        makeButton?.backgroundColor = .black
        makeButton?.setTitle("MAKE", for: .normal)
        makeButton?.titleLabel?.font = UIFont(name: "PingFang SC Thin", size: 20)
        makeButton?.setTitleColor(StyleModel.sharedInstance.homeTextMakeColor , for: .normal)
        makeButton?.addTarget(self, action: #selector(makeAction), for: .touchUpInside)
        
        self.view.addSubview(makeButton!)
    }
    
    func madeDoButton(){
        doButton = UIButton(frame: CGRect(x: 0, y: 351, width: self.view.frame.size.width, height: 100))
        doButton?.backgroundColor = .black
        doButton?.setTitle("DO", for: .normal)
        doButton?.titleLabel?.font = UIFont(name: "PingFang SC Thin", size: 20)
        doButton?.setTitleColor(StyleModel.sharedInstance.homeTextDoColor , for: .normal)
        doButton?.setBackgroundColor(color: StyleModel.sharedInstance.greybuttonColor, forState: .disabled)
        doButton?.addTarget(self, action: #selector(doAction), for: .touchUpInside)
        
        self.view.addSubview(doButton!)
    }
    
    func makeSomethingButton(){
        somethingButton = UIButton(frame: CGRect(x: 0, y: 452, width: self.view.frame.size.width, height: 100))
        somethingButton?.backgroundColor = .black
        somethingButton?.setTitle("SOMETHING", for: .normal)
        somethingButton?.titleLabel?.font = UIFont(name: "PingFang SC Thin", size: 20)
        somethingButton?.setTitleColor(StyleModel.sharedInstance.homeTextSomethingColor , for: .normal)
        somethingButton?.setBackgroundColor(color: StyleModel.sharedInstance.greybuttonColor, forState: .disabled)
        somethingButton?.addTarget(self, action: #selector(somethingAction), for: .touchUpInside)
        
        self.view.addSubview(somethingButton!)
    }
    /*
    func makeHistoryButton(){
        historyButton = UIButton(frame: CGRect(x: 0, y: 453, width: self.view.frame.size.width, height: 100))
        historyButton?.backgroundColor = .black
        historyButton?.setTitle("HISTORY", for: .normal)
        historyButton?.titleLabel?.font = UIFont(name: "PingFang SC Thin", size: 20)
        historyButton?.setTitleColor(StyleModel.sharedInstance.homeTextHistoryColor, for: .normal)
        historyButton?.setBackgroundColor(color: StyleModel.sharedInstance.greybuttonColor, forState: .disabled)
        historyButton?.addTarget(self, action: #selector(historyAction), for: .touchUpInside)
        
        self.view.addSubview(historyButton!)
    }
*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "InitialToThing" {
//            
//            let nextView = segue.destination as! ThingDataViewController
//            let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Thing")
//            request.predicate = NSPredicate(format: "lastCompleted == nil")
//            do{
//                let results = try moc.fetch(request)as! [Thing]
//                let randomIndex = Int(arc4random_uniform(UInt32(results.count)))
//                print(randomIndex)
//                print(results)
//                nextView.getThing = results[randomIndex]
//            }catch{
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
    }
    
    @objc func somethingAction(sender: UIButton!) {
        PredicateFormulator.sharedPredicateFormulator.kind = nil
        PredicateFormulator.sharedPredicateFormulator.time = nil
        PredicateFormulator.sharedPredicateFormulator.completed = false
        performSegue(withIdentifier: "InitialToThings", sender: self)
    }
    
    @objc func historyAction(sender: UIButton!) {
        var statistics = DataStatistics()
        statistics = statistics.dataStatisticsWithCompletion(completed: true)
        
        PredicateFormulator.sharedPredicateFormulator.kind = nil
        PredicateFormulator.sharedPredicateFormulator.time = nil
        PredicateFormulator.sharedPredicateFormulator.completed = true
        performSegue(withIdentifier: "InitialToHistory", sender: self)
    }

     @objc func makeAction(sender: UIButton!) {
        CreateThingWizard.new()
        let workflowItemOne = WorkFlowItem(attribute: "Time", segueIdentifier: "BacktoAttribute", attributePredicate: NSPredicate(format: "id != \(Int64.max)"), selectAttributeClosure: {attribute in CreateThingWizard.sharedCreateThingWizard.thing.time = (attribute as! Time)}
        )
        let workflowItemTwo = WorkFlowItem(attribute: "Kind", segueIdentifier: nil, attributePredicate: NSPredicate(format: "id != \(Int64.max)"), selectAttributeClosure: {attribute in CreateThingWizard.sharedCreateThingWizard.thing.kind = (attribute as! Kind)}
        )
        Workflow.sharedWorkflow.setWorkflow(workflow: [workflowItemOne, workflowItemTwo])
        Workflow.sharedWorkflow.creating = true
        self.performSegue(withIdentifier: "MakeSeuge", sender: self)
    }
    
   @objc func doAction(sender: UIButton!) {
        PredicateFormulator.sharedPredicateFormulator.completed = false

        let workflowItemOne = WorkFlowItem(attribute: "Time", segueIdentifier: "BacktoAttribute", selectAttributeClosure: {attribute in PredicateFormulator.sharedPredicateFormulator.time = (attribute as! Time)}
        )
        let workflowItemTwo = WorkFlowItem(attribute: "Kind", segueIdentifier: "AttributeToThing", selectAttributeClosure: {attribute in PredicateFormulator.sharedPredicateFormulator.kind = (attribute as! Kind)}
        )
        Workflow.sharedWorkflow.setWorkflow(workflow: [workflowItemOne, workflowItemTwo])
        Workflow.sharedWorkflow.creating = false

         self.performSegue(withIdentifier: "StartToAttribute", sender: self)
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
}
