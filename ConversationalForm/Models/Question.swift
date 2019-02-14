//
//  Question.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 12/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

import UIKit

final public class Question {
    let headerTitle: String
    let subheaderTitle: String
    let formType: FormType
    var answer: String?
    
    public init(headerTitle: String, subheaderTitle: String, formType: FormType) {
        self.headerTitle = headerTitle
        self.subheaderTitle = subheaderTitle
        self.formType = formType
    }
}

