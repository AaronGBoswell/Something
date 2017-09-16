//
//  Workflow.swift
//  Something
//
//  Created by Aaron Boswell on 2017-09-15.
//  Copyright © 2017 Aaron Boswell. All rights reserved.
//

import Foundation
class Workflow{
    static var sharedWorkflow:Workflow = Workflow()
    
    public func setWorkflow(workflow: [WorkFlowItem]){
        self.workflow = workflow
    }
    private var workflow:[WorkFlowItem]!
    public func getCurrentWorkFlowItem() -> WorkFlowItem{
        return workflow.first!
    }
    public func nextWorkFlowItem(){
        //cluge alert, casting was all jacked up except if I did this
        //just trying to remove the first element...
        //workflow = workflow.dropFirst(1).reversed().reversed()

        //acctually we put it at the end so pop(3) doesnt kill ourselves.. maybe should handle this elsewhere
        let first = workflow.remove(at: 0)
        workflow.append(first)
    }
}
