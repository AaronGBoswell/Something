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
        textField.text = CreateThingWizard.sharedCreateThingWizard.thing.note ?? ""
        makeDoneButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func backAction(sender: UIButton!) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    func makeDoneButton(){
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneAction)), animated: true)
    }
    
    @objc func doneAction(sender: AnyObject!) {
        CreateThingWizard.sharedCreateThingWizard.thing.note = textField.text;
        CreateThingWizard.sharedCreateThingWizard.save();
        CreateThingWizard.sharedCreateThingWizard.editing = false;
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
