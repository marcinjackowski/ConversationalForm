//
//  RoundedButton.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 19/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

import UIKit

public enum RoundedButtonState {
    case active
    case inactive
}

final public class RoundedButtonStyle {
    let activeColor: UIColor
    let inactiveColor: UIColor
    private var state: RoundedButtonState = .inactive
    
    public init(activeColor: UIColor = #colorLiteral(red: 0.462745098, green: 0.462745098, blue: 0.462745098, alpha: 1), inactiveColor: UIColor = #colorLiteral(red: 0, green: 0.4156862745, blue: 0.4392156863, alpha: 1)) {
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
    }
    
    var color: UIColor {
        switch state {
        case .inactive:
            return inactiveColor
        case .active:
            return activeColor
        }
    }
    
    var alpha: CGFloat {
        switch state {
        case .inactive:
            return 0.25
        case .active:
            return 1.0
        }
    }
    
    func update(state: RoundedButtonState) {
        self.state = state
    }
}

final class RoundedButton: UIButton {
    
    private enum Constants {
        static let contentEdgeInsets = UIEdgeInsets(top: 16.0, left: 24.0, bottom: 16.0, right: 24.0)
        static let borderWidth: CGFloat = 2.0
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let style: RoundedButtonStyle
    var buttonState: RoundedButtonState {
        didSet {
            style.update(state: buttonState)
            setupButton()
        }
    }
    
    init(state: RoundedButtonState = .inactive, theme: Theme) {
        self.buttonState = state
        self.style = theme.roundedButtonStyle
        self.style.update(state: state)
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        contentEdgeInsets = Constants.contentEdgeInsets
        layer.borderWidth = Constants.borderWidth
        layer.cornerRadius = Constants.cornerRadius
        layer.masksToBounds = true
        setTitleColor(style.color, for: .normal)
        layer.borderColor = style.color.cgColor
        alpha = style.alpha
        isEnabled = buttonState == .active
    }
}

