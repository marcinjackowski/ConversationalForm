//
//  PickerView.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 23/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

import UIKit
import Foundation

final class PickerView: UIView {
    
    private enum Constants {
        static let fontSize: CGFloat = 16.0
        static let padding: CGFloat = 16.0
        static let cornerRadius: CGFloat = 8.0
    }
    
    var dateString: String? {
        didSet {
            guard let dateString = dateString, let date = dateFormatter.date(from: dateString) else { return }
            dateLabel.text = dateString
            picker.date = date
        }
    }
    
    let dateLabel = UILabel()
    private let theme: Theme
    private let topHorizontalStackView = UIStackView()
    private let verticalStackView = UIStackView()
    private let leftTitleLabel = UILabel()
    private let picker = UIDatePicker()
    private let dateFormatter = DateFormatter()
    private let bottomPaddingView = UIView()
    
    init(datePickerForm: DatePickerForm, theme: Theme) {
        self.theme = theme
        super.init(frame: .zero)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        setupLayout()
        setupDateLabel()
        setupLeftTitle(title: datePickerForm.leftTitle)
        setupTopHorizontalStackView()
        setupPicker(mode: datePickerForm.mode)
        setupVerticalStackView()
    }
    
    func animateOut() {
        leftTitleLabel.isHidden = true
        picker.isHidden = true
        bottomPaddingView.isHidden = true
        leftTitleLabel.alpha = 0.0
        backgroundColor = theme.primaryColor
        alpha = 0.25
        dateLabel.textColor = .white
    }
    
    func animateIn() {
        leftTitleLabel.alpha = 1.0
        alpha = 1.0
        bottomPaddingView.isHidden = false
        leftTitleLabel.isHidden = false
        picker.isHidden = false
        backgroundColor = .clear
        dateLabel.textColor = theme.primaryColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        layer.borderColor = theme.primaryColor.cgColor
        layer.borderWidth = 2.0
        layer.masksToBounds = true
        layer.cornerRadius = Constants.cornerRadius
    }
    
    private func setupTopHorizontalStackView() {
        addSubview(topHorizontalStackView)
        topHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        topHorizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding).isActive = true
        topHorizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        topHorizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding).isActive = true
        
        topHorizontalStackView.axis = .horizontal
        topHorizontalStackView.alignment = .trailing
        topHorizontalStackView.distribution = .equalCentering
        topHorizontalStackView.addArrangedSubview(leftTitleLabel)
        topHorizontalStackView.addArrangedSubview(dateLabel)
    }
    
    private func setupVerticalStackView() {
        bottomPaddingView.translatesAutoresizingMaskIntoConstraints = false
        bottomPaddingView.heightAnchor.constraint(equalToConstant: Constants.padding).isActive = true
        
        addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.topAnchor.constraint(equalTo: topHorizontalStackView.bottomAnchor, constant: 16.0).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        verticalStackView.axis = .vertical
        verticalStackView.addArrangedSubview(picker)
        verticalStackView.addArrangedSubview(bottomPaddingView)
    }
    
    private func setupLeftTitle(title: String?) {
        leftTitleLabel.text = title
        leftTitleLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
    }
    
    private func setupDateLabel() {
        dateLabel.textAlignment = .right
        dateLabel.textColor = theme.primaryColor
        dateLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
    }
    
    private func setupPicker(mode: UIDatePicker.Mode) {
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = mode
        picker.addTarget(self, action: #selector(self.pickerDidChange(sender:)), for: .valueChanged)
        
        let dateString = dateFormatter.string(from: picker.date)
        dateLabel.text = dateString
    }
    
    @objc func pickerDidChange(sender: UIDatePicker) {
        let dateString = dateFormatter.string(from: sender.date)
        dateLabel.text = dateString
    }
}

