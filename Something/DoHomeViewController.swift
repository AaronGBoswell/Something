//
//  File.swift
//  Something
//
//  Created by Henry Boswell on 9/12/17.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//

import UIKit

class DoHomeViewController: UIViewController ,  UITableViewDataSource, UITableViewDelegate{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(rgb:0x69D300)
        makeBackButton()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    
    func makeBackButton(){
        let button = UIButton(frame: CGRect(x: 20, y: 100, width: 100, height: 50))
        button.backgroundColor = .clear
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor(rgb:0x50514F), for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    
        self.view.addSubview(button)
    }

    func backAction(sender: UIButton!) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }

    
    
    
    //TableView
    @IBOutlet weak var DoTableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cellidentifier", for: indexPath)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    

    
    
}
