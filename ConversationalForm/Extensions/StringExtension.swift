//
//  StringExtension.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 19/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

import UIKit

extension String {
    func calculateWidth(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
