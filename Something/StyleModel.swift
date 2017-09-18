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

    
    var backgroundColor = UIColor(rgb:0x69D300)
    
    
    var kindColors: [String: Int] = ["need to do": 0xff0000,
                                   "nice to do": 0x00ff00,
                                   "want to do": 0x0000ff,
                                   "Doesn't matter": 0xff0000]

    var timeColors: [String: Int] = ["5min": 0xff0000,
                                     "30min": 0x00ff00,
                                     "60min": 0x0000ff,
                                     "Doesn't matter": 0xff0000]

}
