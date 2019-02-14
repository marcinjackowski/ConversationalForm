//
//  SliderView.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 21/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

import UIKit

final class SliderView: UIView {
    
    private enum Constants {
        static let fontSize: CGFloat = 16.0
        static let padding: CGFloat = 16.0
    }
    
    let sliderValueLabel = UILabel()
    private let theme: Theme
    private let topHorizontalStackView = UIStackView()
    private let verticalStackView = UIStackView()
    private let leftTitleLabel = UILabel()
    private let slider = UISlider()
    private let prefixSliderValue: String
    private let suffixSliderValue: String
    
    init(sliderForm: SliderForm, theme: Theme) {
        self.theme = theme
        self.prefixSliderValue = sliderForm.prefixSliderValue
        self.suffixSliderValue = sliderForm.suffixSliderValue
        super.init(frame: .zero)
        setupLayout()
        setupSliderValueLabel()
        setupLeftTitle(title: sliderForm.leftTitle)
        setupTopHorizontalStackView()
        setupSlider(value: sliderForm.value, minimumValue: sliderForm.minimumValue, maximumValue: sliderForm.maximumValue)
        updateSliderValue(value: sliderForm.value)
        setupVerticalStackView()
    }
    
    func animateOut() {
        leftTitleLabel.alpha = 0.0
        slider.alpha = 0.0
        leftTitleLabel.isHidden = true
        slider.isHidden = true
        backgroundColor = theme.primaryColor
        sliderValueLabel.textColor = .white
        alpha = 0.25
    }
    
    func animateIn() {
        leftTitleLabel.alpha = 1.0
        slider.alpha = 1.0
        leftTitleLabel.isHidden = false
        slider.isHidden = false
        backgroundColor = .clear
        sliderValueLabel.textColor = theme.primaryColor
        alpha = 1.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        layer.borderColor = theme.primaryColor.cgColor
        layer.borderWidth = 2.0
        layer.masksToBounds = true
        layer.cornerRadius = 8.0
    }
    
    private func setupTopHorizontalStackView() {
        topHorizontalStackView.axis = .horizontal
        topHorizontalStackView.distribution = .equalSpacing
        topHorizontalStackView.addArrangedSubview(leftTitleLabel)
        topHorizontalStackView.addArrangedSubview(sliderValueLabel)
    }
    
    private func setupVerticalStackView() {
        addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.padding).isActive = true
        verticalStackView.axis = .vertical
        verticalStackView.spacing = Constants.padding        
        verticalStackView.addArrangedSubview(topHorizontalStackView)
        verticalStackView.addArrangedSubview(slider)
    }
    
    private func setupLeftTitle(title: String?) {
        leftTitleLabel.text = title
        leftTitleLabel.font = UIFont.systemFont(ofSize: Constants.fontSize, weight: .regular)
    }
    
    private func setupSliderValueLabel() {
        sliderValueLabel.textColor = theme.primaryColor
        sliderValueLabel.font = UIFont.systemFont(ofSize: Constants.fontSize, weight: .medium)
    }
    
    private func updateSliderValue(value: Float) {
        sliderValueLabel.text = prefixSliderValue + "\(Int(value)) " + suffixSliderValue
    }
    
    private func setupSlider(value: Float, minimumValue: Float, maximumValue: Float) {
        slider.minimumTrackTintColor = theme.primaryColor
        slider.maximumTrackTintColor = #colorLiteral(red: 0.462745098, green: 0.462745098, blue: 0.462745098, alpha: 0.246231294)
        slider.minimumValue = minimumValue
        slider.maximumValue = maximumValue
        slider.value = value
        slider.addTarget(self, action: #selector(self.sliderDidChange(sender:)), for: .valueChanged)
    }
    
    @objc func sliderDidChange(sender: UISlider){
        let step: Float = 1
        let roundedStepValue = round(sender.value / step) * step
        sender.value = roundedStepValue
        updateSliderValue(value: roundedStepValue)
    }
}

