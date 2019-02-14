//
//  ChoiceFormView.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 14/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

import UIKit

final class ChoiceFormView: FormView {
    
    private enum Constants {
        static let horizontalPadding: CGFloat = 24.0
        static let verticalPadding: CGFloat = -56.0
        static let buttonsStackViewSpacing: CGFloat = 8.0
        static let buttonHeight: CGFloat = 48.0
    }

    private let theme: Theme
    private let buttonsStackView = UIStackView()
    private var currentSelectedButton: UIButton?
    
    init(question: Question, buttonTitles: [String], theme: Theme) {
        self.theme = theme
        super.init(question: question, theme: theme)
        setupButtons(titles: buttonTitles)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtons(titles: [String]) {
        addSubview(buttonsStackView)
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constants.horizontalPadding).isActive = true
        buttonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.verticalPadding).isActive = true
        buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalPadding).isActive = true
        buttonsStackView.axis = .vertical
        buttonsStackView.alignment = .trailing
        buttonsStackView.spacing = Constants.buttonsStackViewSpacing
        
        titles.forEach {
            let button = ChoiceButton(theme: theme)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
            button.setTitle($0, for: .normal)
            button.addTarget(self, action: #selector(ChoiceFormView.buttonTapped), for: .touchUpInside)
            buttonsStackView.addArrangedSubview(button)
            
            guard let answer = question.answer else { return }
            
            if $0 != answer {
                button.alpha = 0.0
                button.isHidden = true
            } else {
                button.alpha = 0.25
                button.isSelected = true
            }
        }
    }

    @objc private func buttonTapped(sender: UIButton) {
        sender.isSelected = true
        currentSelectedButton = sender
        tapHandler?(sender.titleLabel?.text ?? "")
    }

    private func animateButtons(isHidden: Bool, except sender: UIButton? = nil) {
        buttonsStackView.arrangedSubviews.forEach {
            $0.alpha = isHidden ? 0.25 : 1.0
            guard let button = $0 as? UIButton, button != sender else { return }
            button.alpha = isHidden ? 0.0 : 1.0
            button.isHidden = isHidden
            button.isSelected = false
        }
    }

    override func animateOut() {
        super.animateOut()
        animateButtons(isHidden: true, except: currentSelectedButton)
    }

    override func animateIn() {
        super.animateIn()
        animateButtons(isHidden: false)
    }
}
