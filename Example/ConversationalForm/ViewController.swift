//
//  ViewController.swift
//  ConversationalForm
//
//  Created by marcinjackowski on 02/13/2019.
//  Copyright (c) 2019 marcinjackowski. All rights reserved.
//

import UIKit
import ConversationalForm

class ViewController: UIViewController {
    
    private var conversationalFormView: ConversationalFormView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        let questions = fetchQuestions()
        
        conversationalFormView = ConversationalFormView(questions: questions)
        view.addSubview(conversationalFormView)
        conversationalFormView.translatesAutoresizingMaskIntoConstraints = false
        conversationalFormView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        conversationalFormView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        conversationalFormView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        conversationalFormView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        conversationalFormView.image = UIImage(named: "logo")
    }
    
    private func fetchQuestions() -> [Question] {
        let q1 = Question(headerTitle: "Hey there,", subheaderTitle: "I'm Alexa and I can help you arrange your next holidays.\n Are you ready?", formType: FormType.choice(titles: ["Yeah! Let's do it!", "No thanks..."]))
        return [q1]
    }
}

