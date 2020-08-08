//
//  ViewController.swift
//  SquareWorkflowDemo
//
//  Created by Alexandru Istrate on 07/08/2020.
//  Copyright © 2020 Alexandru Istrate. All rights reserved.
//

import UIKit

import Workflow
import WorkflowUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Method 1: Works perfectly
        presentOver()
        
        // Method 2: Doesn't work
//        presentEmbedd()
    }
    
    private func presentOver() {
        let container = ContainerViewController(
            workflow: RootWorkflow()
        )
        present(container, animated: true, completion: nil)
    }
    
    private func presentEmbedd() {
        let container = ContainerViewController(
            workflow: RootWorkflow()
        )

        addChild(container)
        let containerView = container.view!
        self.view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        container.didMove(toParent: self)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

