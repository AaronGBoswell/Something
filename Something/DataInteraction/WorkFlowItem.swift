//
//  WorkFlowItem.swift
//  Something
//
//  Created by Aaron Boswell on 2017-09-15.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//

import Foundation
class WorkFlowItem{
    public var attribute:String
    public var segueIdentifier:String
    public var attributePredicate:NSPredicate

    private var selectAttributeClosure:(Attribute)->Void
    
    init(attribute:String, segueIdentifier:String, attributePredicate:NSPredicate, selectAttributeClosure: @escaping (Attribute)->Void) {
        self.attribute = attribute
        self.segueIdentifier = segueIdentifier
        self.attributePredicate = attributePredicate
        self.selectAttributeClosure = selectAttributeClosure
    }
    convenience init(attribute:String, segueIdentifier:String, selectAttributeClosure: @escaping (Attribute)->Void) {
        self.init(attribute: attribute, segueIdentifier: segueIdentifier, attributePredicate: NSPredicate(value: true), selectAttributeClosure: selectAttributeClosure)
    }
    func selectAttribute(attribute:Attribute){
        selectAttributeClosure(attribute)
    }
}
