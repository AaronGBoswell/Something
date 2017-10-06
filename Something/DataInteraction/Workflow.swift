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
    
    private var workflow:[WorkFlowItem]!
    private var stats:DataStatistics = DataStatistics()
    private var workflowIndex = 0
    public func setWorkflow(workflow: [WorkFlowItem]){
        self.workflow = workflow
        workflowIndex = 0
        stats = DataStatistics();
    }

    public func removeFromStats(_ attribute:String){
        stats = stats.statsWithout(attributeString: attribute)
    }
    public func getCurrentWorkFlowItem() -> WorkFlowItem{
        return workflow[workflowIndex]
    }
    public func incrementWorkflow(){
        workflowIndex = min(workflowIndex + 1, workflow.count - 1)
    }
    public func decrementWorkflow(){
        workflowIndex = max(workflowIndex - 1, 0)
    }
    public func addToStats(attribute:Attribute){
        stats = stats.dataStatisticsWith(attribute: attribute)

    }
    public func getCurrentDataStatistics() -> DataStatistics{
        return stats
    }
}
