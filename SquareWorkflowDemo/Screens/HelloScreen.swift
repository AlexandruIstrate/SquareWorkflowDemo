//
//  HelloScreen.swift
//  SquareWorkflowDemo
//
//  Created by Alexandru Istrate on 07/08/2020.
//  Copyright © 2020 Alexandru Istrate. All rights reserved.
//

import Workflow
import WorkflowUI

struct HelloScreen: Screen {
    
    var onNameChanged: (String) -> Void
    var onTextTyped: (String) -> Void
    
    func viewControllerDescription(environment: ViewEnvironment) -> ViewControllerDescription {
        return HelloViewController.description(for: self, environment: environment)
    }
}

private final class HelloViewController: ScreenViewController<HelloScreen>, UITextFieldDelegate {
    private let label = UILabel(frame: .zero)
    private let textField = UITextField(frame: .zero)
    private let doneButton = UIButton(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "What's your name?"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "Your Name Here"
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.link, for: .normal)
        doneButton.addTarget(self, action: #selector(onDoneTapped(_:)), for: .touchUpInside)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(doneButton)
        
        let padding: CGFloat = 16.0
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: padding),
            
            textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4.0),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            doneButton.topAnchor.constraint(equalTo: textField.bottomAnchor),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        ])
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        screen.onNameChanged(textField.text ?? "")
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        screen.onTextTyped(textField.text ?? "")
    }
    
    @objc private func onDoneTapped(_ sender: UIButton) {
        textField.resignFirstResponder()
    }
}
