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
    }

    public func getCurrentWorkFlowItem() -> WorkFlowItem{
        return workflow[workflowIndex]
    }
    public func incrementWorkflow(){
        workflowIndex = workflowIndex + 1
    }
    public func decrementWorkflow(){
        workflowIndex = workflowIndex - 1
    }
    public func addToStats(attribute:Attribute){
        stats = stats.dataStatisticsWithAttibute(attribute: attribute)

    }
    public func getCurrentDataStatistics() -> DataStatistics{
        return stats
    }
}
