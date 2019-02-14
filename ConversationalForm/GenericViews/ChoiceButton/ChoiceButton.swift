//
//  ChoiceButton.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 14/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

import UIKit

//final class ButtonState {
//    private let
//}

final class ChoiceButton: UIButton {
    
    enum ButtonState {
        case active
        case inactive
    }
    
    final class ButtonStyle {
        private var state: ButtonState
        private let theme: Theme
        
        var titleColor: UIColor {
            switch state {
            case .inactive:
                return .white
            case .active:
                return theme.primaryColor
            }
        }

        var borderColor: UIColor {
            return theme.primaryColor
        }

        var backgroundColor: UIColor {
            switch state {
            case .inactive:
                return theme.primaryColor
            case .active:
                return .clear
            }
        }
        
        init(state: ButtonState, theme: Theme) {
            self.state = state
            self.theme = theme
        }
        
        func update(state: ButtonState) {
            self.state = state
        }
    }
    
    private enum Constants {
        static let contentEdgeInsets = UIEdgeInsets(top: 8.0, left: 24.0, bottom: 8.0, right: 24.0)
    }
    
    private let theme: Theme
    private var style: ButtonStyle
    private var buttonState: ButtonState = .active {
        didSet {
            style.update(state: buttonState)
            setupButton()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            isEnabled = !isSelected
            buttonState = isSelected ? .inactive : .active
        }
    }
    
    init(theme: Theme) {
        self.theme = theme
        self.style = ButtonStyle(state: buttonState, theme: theme)
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        contentEdgeInsets = Constants.contentEdgeInsets
        titleLabel?.lineBreakMode = .byWordWrapping
        setTitleColor(style.titleColor, for: .normal)
        backgroundColor = style.backgroundColor
        titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height = frame.height
        roundCorners(topLeft: height/2, topRight: height/2, bottomLeft: height/2, bottomRight: 8.0, borderColor: style.borderColor, borderWidth: 3.0)
    }
}
