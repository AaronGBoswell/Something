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
    
    
     var getThing:Thing?
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = StyleModel.sharedInstance.backgroundColor
        
        
        MakeBackButton()
        MakeEditButton()
        MakeDoneButton()
        MakeTitle()
        MakeThingDataLabel()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func MakeTitle(){
        let label: UILabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
        // label.frame = CGRectDo(50, 50, 200, 21)
        label.backgroundColor = .clear
        label.textColor = StyleModel.sharedInstance.labelColor
        label.textAlignment = NSTextAlignment.center
        label.text = "Data"
        self.view.addSubview(label)
    }
    
    func MakeBackButton(){
        let button = UIButton(frame: CGRect(x: 10, y: 20, width: 100, height: 50))
        button.backgroundColor = .clear
        button.setTitle("Back", for: .normal)
        button.setTitleColor(StyleModel.sharedInstance.buttonColor , for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }

    func MakeEditButton(){
        let button = UIButton(frame: CGRect(x: 100, y: 20, width: 100, height: 50))
        button.backgroundColor = .clear
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(StyleModel.sharedInstance.buttonColor, for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }

    func backAction(sender: UIButton!) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    func MakeDoneButton(){
        let button = UIButton(frame: CGRect(x: 210, y: 20, width: 100, height: 50))
        button.backgroundColor = .clear
        button.setTitle("Done", for: .normal)
        button.setTitleColor(StyleModel.sharedInstance.buttonColor, for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    func MakeThingDataLabel(){
        let label: UILabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
        // label.frame = CGRectDo(50, 50, 200, 21)
        label.backgroundColor = .clear
        label.textColor = StyleModel.sharedInstance.labelColor
        label.textAlignment = NSTextAlignment.center
        label.text = getThing?.title
        self.view.addSubview(label)
    }
   
    
    
}

