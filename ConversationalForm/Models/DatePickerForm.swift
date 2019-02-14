//
//  PickerForm.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 12/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

import UIKit

public struct DatePickerForm {
    let leftTitle: String?
    let mode: UIDatePicker.Mode
    let buttonTitle: String
    
    public init(leftTitle: String?, mode: UIDatePicker.Mode, buttonTitle: String) {
        self.leftTitle = leftTitle
        self.mode = mode
        self.buttonTitle = buttonTitle
    }
}
