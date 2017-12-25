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
    
    var textField: UITextField?
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeInputField()
        self.view.backgroundColor = StyleModel.sharedInstance.backgroundColor
        
        textField?.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.title = "Describe"
        
        textField?.text = CreateThingWizard.sharedCreateThingWizard.thing.title ?? ""
        makeTitleMotto()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        CreateThingWizard.sharedCreateThingWizard.thing.title = textField.text
        textField.resignFirstResponder()
        performSegue(withIdentifier: "Make", sender: self)
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField?.becomeFirstResponder()
    }
    
    @objc func dismissKeyboard() {
        CreateThingWizard.sharedCreateThingWizard.thing.title = textField?.text
        view.endEditing(true)
    }
    
    func makeInputField(){
        textField = UITextField(frame: CGRect(x: 10, y: 150, width: self.view.frame.size.width - 20, height: 70))
        textField?.backgroundColor = .white
        textField?.textAlignment = NSTextAlignment.center
        textField?.text = ""
        textField?.font = UIFont(name: "PingFang SC", size: 20)
        textField?.keyboardType = .default
        textField?.returnKeyType = .done
        self.view.addSubview(textField!)
    }
    
    func makeTitleMotto(){
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 220, width: self.view.frame.size.width, height: 30))
        label.backgroundColor = .clear
        label.textColor = StyleModel.sharedInstance.buttonColor
        label.textAlignment = NSTextAlignment.center
        label.text = "A Thoughtful Description."
        label.font = UIFont(name: "PingFang SC", size: 14)
        self.view.addSubview(label)
    }

    override func viewWillDisappear(_ animated: Bool) {
        if( self.navigationController?.viewControllers.index(of: self) == nil){
            CreateThingWizard.destroy()            
        }
        super.viewWillDisappear(animated)
    }
}
