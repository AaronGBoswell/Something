//
//  MakeNoteViewController.swift
//  Something
//
//  Created by Henry Boswell on 9/12/17.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//

import UIKit
import CoreData


class NoteRememberViewController: UIViewController {
    
    
    
    @IBOutlet weak var textField: UITextView!
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = StyleModel.sharedInstance.backgroundColor
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.title = "Detail"
        //makeBackButton()
        makeDoneButton()
        //makeTitle()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        
        view.endEditing(true)
        
    }
    
    
    func makeTitle(){
        let label: UILabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
        // label.frame = CGRectMake(50, 50, 200, 21)
        label.backgroundColor = .clear
        label.textColor = StyleModel.sharedInstance.labelColor
        label.textAlignment = NSTextAlignment.center
        label.text = "Thing"
        self.view.addSubview(label)
    }
    
    func makeBackButton(){
        let button = UIButton(frame: CGRect(x: 10, y: 20, width: 100, height: 50))
        button.backgroundColor = .clear
        button.setTitle("Back", for: .normal)
        button.setTitleColor(StyleModel.sharedInstance.buttonColor, for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    func backAction(sender: UIButton!) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    func makeDoneButton(){
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneAction)), animated: true)
        //self.view.addSubview(button)
    }
    
    func doneAction(sender: AnyObject!) {
        CreateThingWizard.sharedCreateThingWizard.thing.note = textField.text;
        CreateThingWizard.sharedCreateThingWizard.save();

        //TODO
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

    
}

