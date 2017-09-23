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
    
     var colorView:UIView?
     var getThing:Thing?
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = StyleModel.sharedInstance.backgroundColor
        
        MakeColorView()
        //MakeBackButton()
        //MakeEditButton()
        MakeDoneButton()
        MakeNoteLabel()
        //MakeTitle()
        MakeThingDataLabel()
        MakeThingNoteDataLabel()
        
        self.title = "Selected Task"
        
        
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

    @objc func backAction(sender: UIButton!) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    func MakeDoneButton(){
    
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(backAction)), animated: true)
            //self.view.addSubview(button)
    }
    
    func MakeThingDataLabel(){
        let width = self.view.frame.width
        let label: UILabel = UILabel(frame: CGRect(x: 10, y: 20, width: width - 20, height: 50))
        // label.frame = CGRectDo(50, 50, 200, 21)
        label.backgroundColor = .clear
        label.textColor = StyleModel.sharedInstance.labelColor
        label.textAlignment = NSTextAlignment.left
        label.text = "Task: " + (getThing?.title)!
        self.view.addSubview(label)
    }
    func MakeNoteLabel(){
        let width = self.view.frame.width
        let label: UILabel = UILabel(frame: CGRect(x: 10, y: 70, width: width - 20, height: 50))
        // label.frame = CGRectDo(50, 50, 200, 21)
        label.backgroundColor = .clear
        label.textColor = StyleModel.sharedInstance.labelColor
        label.textAlignment = NSTextAlignment.left
        label.text = "Note: "
        self.view.addSubview(label)
    }
    
    func MakeThingNoteDataLabel(){
        let width = self.view.frame.width
        let height = self.view.frame.height
        let note: UITextView = UITextView(frame: CGRect(x: 20, y: 100, width: width - 40, height: height - 100))
        // label.frame = CGRectDo(50, 50, 200, 21)
        note.backgroundColor = .clear
        note.textColor = StyleModel.sharedInstance.labelColor
        note.textAlignment = NSTextAlignment.center
        note.text = getThing?.note
        self.view.addSubview(note)
    }
    
    
    func MakeColorView(){
        let width = self.view.frame.width
        let height = self.view.frame.height
        colorView  = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        colorView?.backgroundColor = UIColor(rgb: Int((getThing!.kind?.color)!))
        self.view.addSubview(colorView!)
        
        
    }

   
    
    
}

