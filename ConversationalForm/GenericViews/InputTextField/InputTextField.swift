//
//  InputField.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 19/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

import UIKit

final class InputTextField: UITextField {
    
    private enum Constants {
        static let padding: CGFloat = 16.0
        static let borderWidth: CGFloat = 2.0
        static let cornerRadius: CGFloat = 8.0
    }
    
    init(theme: Theme) {
        super.init(frame: .zero)
        setupTextField(theme: theme)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField(theme: Theme) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.padding, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
        rightView = paddingView
        rightViewMode = .always
        
        layer.borderWidth = Constants.borderWidth
        layer.cornerRadius = Constants.cornerRadius
        layer.borderColor = theme.primaryColor.cgColor
        layer.masksToBounds = true
    }
}

