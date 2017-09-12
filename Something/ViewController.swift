//
//  ViewController.swift
//  Something
//
//  Created by Aaron Boswell on 2017-09-11.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func MakeButton(_ sender: Any) {
        self.performSegue(withIdentifier: "MakeSeuge", sender: self)
    }
    
    @IBAction func DoButton(_ sender: Any) {
         self.performSegue(withIdentifier: "DoSeuge", sender: self)
    }
    
    
}
