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

    var backgroundColor = UIColor(rgb:0x1985A1)
    var homeTextMakeColor = UIColor(rgb:0xFF146A)
    var homeTextDoColor = UIColor(rgb:0xFFBB3D)
    var homeTextSomethingColor = UIColor(rgb:0xACF39D)
    var homeTitleColor = UIColor(rgb:0x9FA9B2)
    var homeTextHistoryColor = UIColor(rgb:0x218380)
    var labelColor = UIColor(rgb:0x070600)    //sharp black
    var buttonColor = UIColor(rgb:0x393F42)  //impact grey
    var greybuttonColor = UIColor(rgb:0x393F42)  //impact grey
    
    var kindColors: [String: Int] = ["Need to do.": 0xEA526F,
                                   "Nice to do.": 0xF9CB40,
                                   "Want to do.": 0xBCED09,
                                   "Doesn't matter.": 0xACF39D]

    var timeColors: [String: Int] = ["5min": 0xEA526F,
                                     "30min": 0xF9CB40,
                                     "55min": 0xBCED09,
                                     "Doesn't matter.": 0xACF39D]
    var imageNamesTime: [String: UIImage] = ["5min": UIImage(named: "5min.png")!,
                                             "30min": UIImage(named: "30min.png")!,
                                             "55min": UIImage(named: "55min.png")!,
                                             "Doesn't matter.": UIImage(named: "infmin.png")!]
    
    var imageNamesKind: [String: UIImage] = ["Need to do.": UIImage(named: "imp1.png")!,
                                     "Nice to do.": UIImage(named: "imp2.png")!,
                                     "Want to do.": UIImage(named: "imp3.png")!,
                                     "Doesn't matter.": UIImage(named: "infimp.png")!]
}
