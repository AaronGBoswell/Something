//
//  StyleModel.swift
//  Something
//
//  Created by Henry Boswell on 9/17/17.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//

import Foundation

import UIKit

class StyleModel  {
    static let sharedInstance = StyleModel()

    
    var backgroundColor = UIColor(rgb:0x4286f4)
    //puke green: UIColor(rgb:0x69D300)
    
    var labelColor = UIColor(rgb:0x070600)
    var buttonColor = UIColor(rgb:0x7A306C)
    
    var kindColors: [String: Int] = ["need to do": 0xF9CB40,
                                   "nice to do": 0xEA526F,
                                   "want to do": 0xBCED09,
                                   "Doesn't matter": 0xACF39D]

    var timeColors: [String: Int] = ["5min": 0xF9CB40,
                                     "30min": 0xEA526F,
                                     "60min": 0xBCED09,
                                     "Doesn't matter": 0xACF39D]

}
