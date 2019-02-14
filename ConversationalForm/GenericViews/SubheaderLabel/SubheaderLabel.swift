//
//  SubheaderLabel.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 14/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

import UIKit

final class SubheaderLabel: UILabel {
    
    private enum Constants {
        static let lineSpacing: CGFloat = 5.0
    }
    
    private let theme: Theme
    override var text: String? {
        didSet {
            setupTitleLabel(text: text)
        }
    }
    
    init(theme: Theme) {
        self.theme = theme
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitleLabel(text: String?) {
        font = UIFont(name: "\(theme.fontFamilyName)-Light", size: 18.0)
        textColor = theme.questionFontColor
        numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = Constants.lineSpacing
        let attrString = NSMutableAttributedString(string: text ?? "")
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range: NSMakeRange(0, attrString.length))
        attributedText = attrString
    }
}

