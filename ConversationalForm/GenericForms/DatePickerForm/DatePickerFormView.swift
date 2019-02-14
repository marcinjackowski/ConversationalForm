//
//  DatePickerFormView.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 22/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

import UIKit

class DatePickerFormView: FormView {
    
    private enum Constants {
        static let horizontalPadding: CGFloat = 24.0
        static let verticalPadding: CGFloat = -56.0
        static let buttonsStackViewSpacing: CGFloat = 8.0
        static let buttonHeight: CGFloat = 48.0
    }
    
    private let pickerView: PickerView
    private let button: RoundedButton
    private var leadingAnchorConstraint: NSLayoutConstraint?

    init(question: Question, datePickerForm: DatePickerForm, theme: Theme) {
        button = RoundedButton(state: .active, theme: theme)
        pickerView = PickerView(datePickerForm: datePickerForm, theme: theme)
        super.init(question: question, theme: theme)
        setupDatePicker()
        setupButton(title: datePickerForm.buttonTitle)
        
        guard let answer = question.answer else { return }
        leadingAnchorConstraint?.isActive = false
        pickerView.animateOut()
        button.alpha = 0.0
        pickerView.dateString = answer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDatePicker() {
        addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constants.horizontalPadding).isActive = true
        leadingAnchorConstraint = pickerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalPadding)
        leadingAnchorConstraint?.isActive = true
        pickerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalPadding).isActive = true
    }
    
    private func setupButton(title: String) {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: Constants.buttonsStackViewSpacing).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.verticalPadding).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalPadding).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(DatePickerFormView.buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        tapHandler?(pickerView.dateLabel.text ?? "")
    }
    
    override func animateOut() {
        super.animateOut()
        leadingAnchorConstraint?.isActive = false
        layoutIfNeeded()
        pickerView.animateOut()
        button.alpha = 0.0
    }
    
    override func animateIn() {
        super.animateIn()
        leadingAnchorConstraint?.isActive = true
        layoutIfNeeded()
        pickerView.animateIn()
        button.alpha = 1.0
    }
}

