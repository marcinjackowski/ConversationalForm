//
//  FormView.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 14/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

import UIKit

class FormView: UIView {
    
    let headerView: HeaderView
    var question: Question
    var tapHandler: ((_ answer: String) -> ())?

    init(question: Question, theme: Theme) {
        self.question = question
        self.headerView = HeaderView(headerTitle: question.headerTitle, subheaderTitle: question.subheaderTitle, theme: theme)
        super.init(frame: .zero)
        setupHeaderView()
        
        guard let _ = question.answer else { return }
        headerView.animateOut()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHeaderView() {
        addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: topAnchor, constant: 12.0).isActive = true
        headerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.0).isActive = true
        headerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -72.0).isActive = true
    }
    
    func animateIn() {
        headerView.animateIn()
    }
    
    func animateOut() {
        headerView.animateOut()
    }
}
