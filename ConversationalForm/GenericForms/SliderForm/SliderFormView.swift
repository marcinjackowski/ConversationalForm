//
//  SliderFormView.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 21/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

import UIKit

final class SliderFormView: FormView {
    
    private enum Constants {
        static let horizontalPadding: CGFloat = 24.0
        static let verticalPadding: CGFloat = -56.0
        static let buttonsStackViewSpacing: CGFloat = 8.0
        static let buttonHeight: CGFloat = 48.0
    }
    
    private let button: RoundedButton
    private let sliderView: SliderView
    private var leadingAnchorConstraint: NSLayoutConstraint?

    init(question: Question, sliderForm: SliderForm, theme: Theme) {
        button = RoundedButton(state: .active, theme: theme)
        sliderView = SliderView(sliderForm: sliderForm, theme: theme)
        super.init(question: question, theme: theme)
        setupSliderView()
        setupButton(title: sliderForm.buttonTitle)
        
        guard question.answer != nil else { return }
        leadingAnchorConstraint?.isActive = false
        sliderView.animateOut()
        button.alpha = 0.0
        sliderView.sliderValueLabel.text = question.answer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSliderView() {
        addSubview(sliderView)
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        sliderView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constants.horizontalPadding).isActive = true
        leadingAnchorConstraint = sliderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalPadding)
        leadingAnchorConstraint?.isActive = true
        sliderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalPadding).isActive = true
    }
    
    private func setupButton(title: String) {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: sliderView.bottomAnchor, constant: Constants.buttonsStackViewSpacing).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.verticalPadding).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalPadding).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(SliderFormView.buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        tapHandler?(sliderView.sliderValueLabel.text ?? "")
    }
    
    override func animateOut() {
        super.animateOut()
        leadingAnchorConstraint?.isActive = false
        layoutIfNeeded()
        sliderView.animateOut()
        button.alpha = 0.0
    }
    
    override func animateIn() {
        super.animateIn()
        leadingAnchorConstraint?.isActive = true
        layoutIfNeeded()
        sliderView.animateIn()
        button.alpha = 1.0
    }
}

