//
//  InputForm.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 19/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

import UIKit

final class InputFormView: FormView {
    
    private enum Constants {
        static let height: CGFloat = 48.0
        static let bottomPaddingToSuperview: CGFloat = 56.0
        static let fontSize: CGFloat = 16.0
        static let bottomPaddingToButton: CGFloat = 8.0
        static let horizontalPadding: CGFloat = 24.0
    }
    
    private let inputTextField: InputTextField
    private let theme: Theme
    private let button: RoundedButton
    private var leadingAnchorConstraint: NSLayoutConstraint?
    
    init(question: Question, inputForm: InputForm, theme: Theme) {
        self.theme = theme
        button = RoundedButton(theme: theme)
        inputTextField = InputTextField(theme: theme)
        super.init(question: question, theme: theme)
        setupInputTextField(placeholder: inputForm.placeholder)
        setupButton(title: inputForm.buttonTitle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInputTextField(placeholder: String?) {
        addSubview(inputTextField)
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constants.horizontalPadding).isActive = true
        inputTextField.heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
        inputTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalPadding).isActive = true
        leadingAnchorConstraint = inputTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalPadding)
        leadingAnchorConstraint?.isActive = true
        
        inputTextField.placeholder = placeholder
        inputTextField.addTarget(self, action: #selector(self.textFieldDidChange(sender:)), for: .editingChanged)
        inputTextField.font = UIFont.systemFont(ofSize: Constants.fontSize, weight: .regular)
        inputTextField.delegate = self
        
        guard let answer = question.answer else { return }
        inputTextField.text = answer
        let labelWidth = inputTextField.text!.calculateWidth(withConstrainedHeight: Constants.height, font: UIFont.systemFont(ofSize: Constants.fontSize, weight: .regular))
        leadingAnchorConstraint?.constant = (UIScreen.main.bounds.width - labelWidth - Constants.bottomPaddingToSuperview)
        inputTextField.backgroundColor = theme.primaryColor
        inputTextField.textColor = .white
        inputTextField.alpha = 0.25
        button.alpha = 0.0
    }
    
    @objc func textFieldDidChange(sender: UITextField){
        button.buttonState = sender.text?.isEmpty == true ? .inactive : .active
    }
    
    private func setupButton(title: String) {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: Constants.bottomPaddingToButton).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.bottomPaddingToSuperview).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalPadding).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(InputFormView.buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        inputTextField.resignFirstResponder()
        tapHandler?(inputTextField.text ?? "")
    }
    
    override func animateOut() {
        super.animateOut()
        layoutIfNeeded()
        let text = inputTextField.text ?? ""
        let labelWidth = text.calculateWidth(withConstrainedHeight: Constants.height, font: UIFont.systemFont(ofSize: Constants.fontSize, weight: .regular))
        leadingAnchorConstraint?.constant = (UIScreen.main.bounds.width - labelWidth - Constants.bottomPaddingToSuperview)
        inputTextField.alpha = 0.25
        button.alpha = 0.0
        layoutIfNeeded()
        inputTextField.backgroundColor = theme.primaryColor
        inputTextField.textColor = .white
        inputTextField.isEnabled = false
    }
    
    override func animateIn() {
        super.animateIn()
        inputTextField.alpha = 1.0
        button.alpha = 1.0
        leadingAnchorConstraint?.constant = Constants.horizontalPadding
        layoutIfNeeded()
        inputTextField.backgroundColor = .clear
        inputTextField.textColor = .black
        inputTextField.isEnabled = true
        
        guard let _ = question.answer else { return }
        button.buttonState = .active
    }
}

extension InputFormView: UITextFieldDelegate {
    override func didChangeValue(forKey key: String) {
        guard !key.isEmpty else { return }
        button.buttonState = .active
    }
}
