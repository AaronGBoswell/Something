//
//  AttributeExtensions.swift
//  Something
//
//  Created by Aaron Boswell on 2017-09-16.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//

import Foundation

protocol Attribute {
    var alpha:Float {get set};
    var color:Int64 {get set};
    var icon:NSData? {get set};
    var id:Int64 {get set};
    var title:String?{get set};
}
extension Time:Attribute{
    
}
extension Kind:Attribute{
    
}
