//
//  DoTableViewCell.swift
//  Something
//
//  Created by Henry Boswell on 9/15/17.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//


import UIKit
class ThingTableViewCell: UITableViewCell {
    var baseView:UIView?
    var color:UIColor?
    var dataString:String?
    
    func initialize(color :UIColor, data: String){
        self.color = color        // color from model
        self.dataString = data   //eg time, kind and so on
        makeBaseView()
        makeLabel()
        

        //cludge alert!!!! cannot make contentview clear, need to fix this
        self.contentView.backgroundColor = StyleModel.sharedInstance.backgroundColor
        
        
    }
    
    
    func makeLabel(){
        
        let label: UILabel = UILabel(frame: CGRect(x: 20, y: 10, width: 200, height: 30))
        // label.frame = CGRectDo(50, 50, 200, 21)
        label.backgroundColor = .clear
        label.textColor = StyleModel.sharedInstance.labelColor
        label.textAlignment = NSTextAlignment.left
        label.text = "Thing: " + dataString!
        baseView?.addSubview(label)
    }
    func makeBaseView(){
        let width = self.contentView.frame.width
        let height = self.contentView.frame.height
        baseView  = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        baseView?.backgroundColor = color!
        self.contentView.addSubview(baseView!)
        
        
    }

    
   
  
}
