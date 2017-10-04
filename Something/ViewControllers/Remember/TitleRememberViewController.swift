//
//  MakeThingViewController.swift
//  Something
//
//  Created by Henry Boswell on 9/12/17.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//

import UIKit
import CoreData


class TitleRememberViewController: UIViewController,UITextFieldDelegate{
    
    
    //TODO This should not be capital
    @IBOutlet weak var textField: UITextView!
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = StyleModel.sharedInstance.backgroundColor
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.title = "Describe"
        textField.keyboardType = .default
        
        textField.text = CreateThingWizard.sharedCreateThingWizard.thing.title ?? ""
        makeTitleMotto()
        //makeBackButton()
        //makeTitle()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        performSegue(withIdentifier: "Make", sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
        
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        //TODO
        CreateThingWizard.sharedCreateThingWizard.thing.title = textField.text
        view.endEditing(true)
         performSegue(withIdentifier: "Make", sender: self)
        
    }
    
    func makeTitleMotto(){
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 70, width: self.view.frame.size.width, height: 200))
        // label.frame = CGRectMake(50, 50, 200, 21)
        label.backgroundColor = .clear
        label.textColor = StyleModel.sharedInstance.buttonColor
        label.textAlignment = NSTextAlignment.center
        label.text = "A Thoughtful Title."
        label.font = UIFont(name: "PingFang SC", size: 14)
        self.view.addSubview(label)
    }

    
    func makeTitle(){
        let label: UILabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 70))
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
        button.setTitleColor(StyleModel.sharedInstance.buttonColor , for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    @objc func backAction(sender: AnyObject!) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }

}

