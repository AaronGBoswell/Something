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
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var DoTableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cellidentifier", for: indexPath)
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    

    
    
}
