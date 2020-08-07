//
//  HelloWorkflow.swift
//  SquareWorkflowDemo
//
//  Created by Alexandru Istrate on 07/08/2020.
//  Copyright © 2020 Alexandru Istrate. All rights reserved.
//

import Workflow
import WorkflowUI

struct HelloWorkflow: Workflow {
    typealias Output = String
}

extension HelloWorkflow {
    struct State {
        var name: String
    }
    
    func makeInitialState() -> State {
        return State(name: "")
    }
    
    func workflowDidChange(from previousWorkflow: HelloWorkflow, state: inout State) {
        
    }
}

extension HelloWorkflow {
    enum Action: WorkflowAction {
        typealias WorkflowType = HelloWorkflow
        
        case sayHello(name: String)
        case updatedText(text: String)
        
        func apply(toState state: inout WorkflowType.State) -> WorkflowType.Output? {
            switch self {
            case .sayHello(let name):
                state.name = name
                return "Hello, \(state.name)"
            case .updatedText(let text):
                return "Last text is: \(text)"
            }
        }
    }
}

extension HelloWorkflow {
    typealias Rendering = HelloScreen
    
    func render(state: State, context: RenderContext<HelloWorkflow>) -> HelloScreen {
        let sink = context.makeSink(of: HelloWorkflow.Action.self)
        return HelloScreen(onNameChanged: { name in
            sink.send(.sayHello(name: name))
        }, onTextTyped: { text in
            sink.send(.updatedText(text: text))
        })
    }
}
