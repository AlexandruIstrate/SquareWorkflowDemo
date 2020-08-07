//
//  GraphScreen.swift
//  SquareWorkflowDemo
//
//  Created by Alexandru Istrate on 07/08/2020.
//  Copyright © 2020 Alexandru Istrate. All rights reserved.
//

import Workflow
import WorkflowUI

struct GraphScreen: Screen {
    var baseScreen: AnyScreen
    var key: AnyHashable

    init<ScreenType: Screen, Key: Hashable>(base screen: ScreenType, key: Key?) {
        self.baseScreen = AnyScreen(screen)
        if let key = key {
            self.key = AnyHashable(key)
        } else {
            self.key = AnyHashable(ObjectIdentifier(ScreenType.self))
        }
    }

    init<ScreenType: Screen>(base screen: ScreenType) {
        let key = Optional<AnyHashable>.none
        self.init(base: screen, key: key)
    }

    func viewControllerDescription(environment: ViewEnvironment) -> ViewControllerDescription {
        return GraphViewController.description(for: self, environment: environment)
    }
}

private final class GraphViewController: ScreenViewController<GraphScreen> {
    var childViewController: DescribedViewController
    
    required init(screen: GraphScreen, environment: ViewEnvironment) {
        self.childViewController = DescribedViewController(screen: screen.baseScreen, environment: environment)
        super.init(screen: screen, environment: environment)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(childViewController)
        view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        childViewController.view.frame = view.bounds
    }
    
    override func screenDidChange(from previousScreen: GraphScreen, previousEnvironment: ViewEnvironment) {
        
    }
}
