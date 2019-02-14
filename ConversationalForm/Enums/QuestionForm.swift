//
//  QuestionForm.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 12/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

import UIKit

public enum FormType {
    case choice(titles: [String])
    case input(InputForm)
    case datePicker(DatePickerForm)
    case slider(SliderForm)
    case custom(UIView)
}
