//
//  InputForm.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 12/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

public struct InputForm {
    let placeholder: String?
    let buttonTitle: String
    
    public init(placeholder: String?, buttonTitle: String) {
        self.placeholder = placeholder
        self.buttonTitle = buttonTitle
    }
}
