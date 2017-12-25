//
//  DoTableViewCell.swift
//  Something
//
//  Created by Henry Boswell on 9/15/17.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//
import UIKit
import MGSwipeTableCell


class ThingTableViewCell: MGSwipeTableCell{
    var baseView:UIView?
    var color:UIColor?
    var data:Thing?
    
    func initialize( data: Thing){
        self.data = data   //eg time, kind and so on
        self.color = UIColor(rgb: Int((data.kind?.color)!), a: CGFloat((data.kind?.alpha)!))
        makeBaseView()
        makeLabel()
        
        //cludge alert!!!! cannot make contentview clear, need to fix this
        self.contentView.backgroundColor = StyleModel.sharedInstance.backgroundColor
        
        
        //configure left buttons
        self.leftButtons = [MGSwipeButton(title: "", icon: UIImage(named:"check.png"), backgroundColor: .green),
                            MGSwipeButton(title: "", icon: UIImage(named:"fav.png"), backgroundColor: .blue)]
        self.leftSwipeSettings.transition = .clipCenter
        
        //configure right buttons
        self.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: .red),
                             MGSwipeButton(title: "More",backgroundColor: .lightGray)]
        self.rightSwipeSettings.transition = .clipCenter

        
    }

    func makeLabel(){
        let label: UILabel = UILabel(frame: CGRect(x: 20, y: 20, width: 400, height: 30))
        // label.frame = CGRectDo(50, 50, 200, 21)
        label.backgroundColor = .clear
        label.textColor = StyleModel.sharedInstance.labelColor
        label.textAlignment = NSTextAlignment.left
        label.text = data?.title!
        label.font = UIFont(name: "PingFang SC", size: 30)
        baseView?.addSubview(label)
    }
    
    func makeBaseView(){
        let width = self.contentView.frame.width
        let height = self.contentView.frame.height
        baseView  = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        baseView?.backgroundColor = color
        self.contentView.addSubview(baseView!)
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        self.setNeedsLayout()
    }
}
