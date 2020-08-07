//
//  RootWorkflow.swift
//  SquareWorkflowDemo
//
//  Created by Alexandru Istrate on 07/08/2020.
//  Copyright © 2020 Alexandru Istrate. All rights reserved.
//

import Workflow
import WorkflowUI

struct RootWorkflow: Workflow {
    typealias Output = Never
}

extension RootWorkflow {
    struct State { }
    
    func makeInitialState() -> State {
        return State()
    }
    
    func workflowDidChange(from previousWorkflow: RootWorkflow, state: inout State) {
        
    }
}

extension RootWorkflow {
    enum Action: WorkflowAction {
        typealias WorkflowType = RootWorkflow
        
        case run(text: String)
        
        func apply(toState state: inout RootWorkflow.State) -> Never? {
            switch self {
            case .run(let text):
                print(text)
            }
            
            return nil
        }
    }
}

extension RootWorkflow {
    typealias Rendering = GraphScreen
    
    func render(state: State, context: RenderContext<RootWorkflow>) -> GraphScreen {
        return GraphScreen(
            base: HelloWorkflow()
                .mapOutput { output -> RootWorkflow.Action in
                    return .run(text: output)
                }
                .rendered(with: context),
            key: "Hello")
    }
}
