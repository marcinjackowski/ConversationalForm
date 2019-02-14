//
//  SliderForm.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 12/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

public struct SliderForm {
    let leftTitle: String?
    let value: Float
    let minimumValue: Float
    let maximumValue: Float
    let prefixSliderValue: String
    let suffixSliderValue: String
    let buttonTitle: String
    
    public init(leftTitle: String?, value: Float, minimumValue: Float, maximumValue: Float, prefixSliderValue: String, suffixSliderValue: String, buttonTitle: String) {
        self.leftTitle = leftTitle
        self.value = value
        self.minimumValue = minimumValue
        self.maximumValue = maximumValue
        self.prefixSliderValue = prefixSliderValue
        self.suffixSliderValue = suffixSliderValue
        self.buttonTitle = buttonTitle
    }
}
