//
//  HeaderView.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 14/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

import UIKit

final class HeaderView: UIView {
    
    private enum Constants {
        static let verticalPadding: CGFloat = 12.0
        static let leadingPadding: CGFloat = 24.0
        static let trailingPadding: CGFloat = -72.0
    }
    
    private let headerLabel: HeaderLabel
    private let subheaderLabel: SubheaderLabel
    
    init(headerTitle: String, subheaderTitle: String, theme: Theme) {
        self.headerLabel = HeaderLabel(theme: theme)
        self.subheaderLabel = SubheaderLabel(theme: theme)
        super.init(frame: .zero)
        setupHeaderLabel(title: headerTitle)
        setupSubheaderLabel(title: subheaderTitle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHeaderLabel(title: String) {
        addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.verticalPadding).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.trailingPadding).isActive = true
        headerLabel.text = title
    }
    
    private func setupSubheaderLabel(title: String) {
        addSubview(subheaderLabel)
        subheaderLabel.translatesAutoresizingMaskIntoConstraints = false
        subheaderLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: Constants.verticalPadding).isActive = true
        subheaderLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor).isActive = true
        subheaderLabel.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor).isActive = true
        subheaderLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        subheaderLabel.text = title
    }
    
    func animateIn() {
        [headerLabel, subheaderLabel].forEach { $0.alpha = 1.0 }
    }
    
    func animateOut() {
        [headerLabel, subheaderLabel].forEach { $0.alpha = 0.25 }
    }
}
