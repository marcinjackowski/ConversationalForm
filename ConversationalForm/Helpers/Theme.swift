//
//  Theme.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 13/02/2019.
//  Copyright © 2019 Marcin Jackowski. All rights reserved.
//

import UIKit

final public class Theme {
    let primaryColor: UIColor
    let backgroundColor: UIColor
    let questionFontColor: UIColor
    let roundedButtonStyle: RoundedButtonStyle
    let fontFamilyName: String
    
    public init(primaryColor: UIColor = #colorLiteral(red: 1, green: 0.3529411765, blue: 0.3764705882, alpha: 1), backgroundColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), questionFontColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), roundedButtonStyle: RoundedButtonStyle = RoundedButtonStyle(), fontFamilyName: String = "RobotoSlab") {
        self.primaryColor = primaryColor
        self.backgroundColor = backgroundColor
        self.questionFontColor = questionFontColor
        self.roundedButtonStyle = roundedButtonStyle
        self.fontFamilyName = fontFamilyName
    }
}
