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
    
    
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(rgb:0x69D300)
        
        
        MakeBackButton()
        MakeEditButton()
        MakeDoneButton()
        MakeTitle()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func MakeTitle(){
        let label: UILabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 100))
        // label.frame = CGRectDo(50, 50, 200, 21)
        label.backgroundColor = .clear
        label.textColor = UIColor(rgb:0x50514F)
        label.textAlignment = NSTextAlignment.center
        label.text = "Data"
        self.view.addSubview(label)
    }
    
    func MakeBackButton(){
        let button = UIButton(frame: CGRect(x: 100, y: 20, width: 100, height: 50))
        button.backgroundColor = .clear
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor(rgb:0x50514F), for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }

    func MakeEditButton(){
        let button = UIButton(frame: CGRect(x: 200, y: 20, width: 100, height: 50))
        button.backgroundColor = .clear
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(UIColor(rgb:0x50514F), for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }

    func backAction(sender: UIButton!) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    func MakeDoneButton(){
        let button = UIButton(frame: CGRect(x: 400, y: 20, width: 100, height: 50))
        button.backgroundColor = .clear
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor(rgb:0x50514F), for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
   
    
    
}

