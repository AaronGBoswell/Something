//
//  MakeTableViewCell.swift
//  Something
//
//  Created by Henry Boswell on 9/15/17.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//
import UIKit

class AttributeTableViewCell: UITableViewCell {
    var baseView:UIView?
    var color:UIColor?
    var dataString:String?
    var statString:String?
    var imageForCell:UIImage?
    var imageViewForCell: UIImageView?
    
    func initialize(color :UIColor, data: String, stat: String, imageForCell:UIImage){
        self.color = color        // color from model
        self.dataString = data   //eg time, kind and so on
        self.statString = stat
        self.imageForCell = imageForCell
        makeBaseView()
        makeLabel()
        makeStatLabel()
        makeImageView()
    }
    
    func makeLabel(){
        let label: UILabel = UILabel(frame: CGRect(x: 20, y: 30, width: 400, height: 30))
        label.backgroundColor = .clear
        label.textColor = StyleModel.sharedInstance.labelColor
        label.textAlignment = NSTextAlignment.left
        label.text = dataString!
        label.font = UIFont(name: "PingFang SC", size: 35)
        baseView?.addSubview(label)
    }
    
    func makeStatLabel(){
        let statLabel: UILabel = UILabel(frame: CGRect(x: 22, y: 100, width: 200, height: 30))
        statLabel.backgroundColor = .clear
        statLabel.textColor = StyleModel.sharedInstance.labelColor
        statLabel.textAlignment = NSTextAlignment.left
        statLabel.text = statString! + " Common Items"      //here is an excuse for a terenery operator
        baseView?.addSubview(statLabel)
    }
    
    func makeBaseView(){
        let width = self.contentView.frame.width
        let height = self.contentView.frame.height
        baseView  = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        baseView?.backgroundColor = color!
        self.contentView.addSubview(baseView!)
    }
    func makeImageView(){
        let width = self.contentView.frame.width
        //let height = self.contentView.frame.height
        imageViewForCell  = UIImageView(frame: CGRect(x: width - 100, y: (((baseView?.frame.height)!/2)-25), width: 50, height: 50))
        imageViewForCell?.image = imageForCell
        baseView?.addSubview(imageViewForCell!)
    }
}
