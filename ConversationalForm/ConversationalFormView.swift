//
//  ConversationalFormView.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 12/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

import UIKit

protocol ConversationalFormViewDelegate: class {
    func userAnswer(for question: Question, answer: String)
    func summary(questions: [Question])
    func userDidResponseForAllQuestions()
}

extension ConversationalFormViewDelegate {
    func userAnswer(for question: Question, answer: String) {}
    func summary(questions: [Question]) {}
    func userDidResponseForAllQuestions() {}
}

final class ConversationalFormView: UIView {
    
    private enum Constants {
        static let padding: CGFloat = 24.0
        static let animationDuration: Double = 0.3
    }
    
    var image: UIImage? {
        didSet {
            setupImageView(image: image)
        }
    }
    
    weak var delegate: ConversationalFormViewDelegate?
    
    private var questions: [Question]!
    private let theme: Theme
    private let containers = (0...2).map { _ in ContainerView() }
    private var currentQuestionPosition = 0
    private var imageView: UIImageView?
    private var imageViewBottomToTopContainerConstraint: NSLayoutConstraint?
    private var containerViewBottomToSuperviewConstraint: NSLayoutConstraint?

    init(questions: [Question], theme: Theme = Theme()) {
        self.questions = questions
        self.theme = theme
        super.init(frame: .zero)
        setupContainers()
        setupKeyobard()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupKeyobard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        let container = containers.filter { $0.position == .bottom }.first
        container?.bottomConstraint?.constant = -(keyboardHeight - (2 * Constants.padding))
        UIView.animate(withDuration: Constants.animationDuration) {
            self.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide() {
        let container = containers.filter { $0.position == .bottom }.first
        container?.bottomConstraint?.constant = 0.0
        UIView.animate(withDuration: Constants.animationDuration) {
            self.layoutIfNeeded()
        }
    }
    
    private func setupContainers() {
        backgroundColor = theme.backgroundColor
        containers.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            $0.bottomConstraint = $0.bottomAnchor.constraint(equalTo: bottomAnchor)
            $0.bottomConstraint?.isActive = true
            $0.tapHandler = { [weak self] in
                self?.previousQuestion()
            }
        }
        
        let container = containers.first!
        container.position = .bottom
        addViewTo(container: container, from: currentQuestionPosition)
    }
    
    private func setupImageView(image: UIImage?) {
        imageView = UIImageView(image: image)
        addSubview(imageView!)
        imageView!.translatesAutoresizingMaskIntoConstraints = false
        imageView!.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.padding).isActive = true
        imageViewBottomToTopContainerConstraint = imageView!.bottomAnchor.constraint(equalTo: containers.first!.topAnchor, constant: -Constants.padding)
        imageViewBottomToTopContainerConstraint?.isActive = true
    }
    
    private func addViewTo(container: ContainerView?, from position: Int) {
        let question = questions[position]
        var formView: FormView?
        
        switch question.formType {
        case let .choice(titles):
            formView = ChoiceFormView(question: question, buttonTitles: titles, theme: theme)
        case let .input(inputForm):
            formView = InputFormView(question: question, inputForm: inputForm, theme: theme)
        case let .slider(sliderForm):
            formView = SliderFormView(question: question, sliderForm: sliderForm, theme: theme)
        case let .datePicker(datePickerForm):
            formView = DatePickerFormView(question: question, datePickerForm: datePickerForm, theme: theme)
        default: ()
        }
        
        guard let unwrappedFormView = formView else { return }
        unwrappedFormView.tapHandler = { [weak self] answer in
            self?.questions[position].answer = answer
            self?.delegate?.userAnswer(for: question, answer: answer)
            self?.nextQuestion()
        }
        container?.add(view: unwrappedFormView)
    }

    private func nextQuestion() {
        guard currentQuestionPosition + 1 < questions.count else { return finishForm() }
        currentQuestionPosition += 1
        
        let currentBottomView = containers.filter { $0.position == .bottom }.first
        let newBottomView = containers.filter { $0.position == .out }.first
        let currentTopView = containers.filter { $0.position == .top }.first
        
        currentBottomView?.resignFirstResponder()
        newBottomView?.alpha = 0
        addViewTo(container: newBottomView, from: currentQuestionPosition)
        layoutIfNeeded()
        updateImageViewConstraint(to: newBottomView)
        
        UIView.animate(withDuration: Constants.animationDuration, animations: {
            self.layoutIfNeeded()
            self.animate(container: currentTopView, fromPosition: .top, toPosition: .out)
            self.animate(container: currentBottomView, fromPosition: .bottom, toPosition: .top)
        }) { _ in
            currentTopView?.alpha = 0.0
            currentTopView?.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
        }
        UIView.animate(withDuration: Constants.animationDuration, delay: Constants.animationDuration, options: .curveEaseInOut, animations: {
            self.animate(container: newBottomView, fromPosition: .out, toPosition: .bottom)
        })
    }
    
    private func previousQuestion() {
        guard currentQuestionPosition - 1 >= 0 else { return }
        
        currentQuestionPosition -= 1
        questions[currentQuestionPosition].answer = nil
        let currentTopView = containers.filter { $0.position == .top }.first!
        let currentBottomView = containers.filter { $0.position == .bottom }.first!
        let newTopView = containers.filter({ _ in currentQuestionPosition != 0 }).filter { $0.position == .out }.first
        updateImageViewConstraint(to: currentTopView)

        currentBottomView.resignFirstResponder()
        if let newTopView = newTopView {
            let position = currentQuestionPosition - 1
            addViewTo(container: newTopView, from: position)
        }
        newTopView?.transform = CGAffineTransform(translationX: 0.0, y: -bounds.height)
        
        UIView.animate(withDuration: Constants.animationDuration, animations: {
            self.layoutIfNeeded()
            self.animate(container: currentTopView, fromPosition: .top, toPosition: .bottom)
            self.animate(container: currentBottomView, fromPosition: .bottom, toPosition: .out)
        })
        UIView.animate(withDuration: Constants.animationDuration, delay: Constants.animationDuration, options: .curveEaseInOut, animations: {
            self.animate(container: newTopView, fromPosition: .out, toPosition: .top)
        })
    }
    
    private func animate(container: ContainerView?, fromPosition: ContainerViewPosition, toPosition: ContainerViewPosition) {
        switch (fromPosition, toPosition) {
        case (.bottom, .top):
            let yPosition = -(bounds.height - (bounds.height / 4.0))
            container?.transform = CGAffineTransform(translationX: 0.0, y: yPosition)
            container?.animateOut()
            container?.position = .top
        case (.out, .bottom):
            container?.alpha = 1.0
            container?.position = .bottom
        case (.top, .out):
            container?.transform = CGAffineTransform(translationX: 0.0, y: -bounds.height)
            container?.position = .out
        case (.top, .bottom):
            container?.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
            container?.animateIn()
            container?.position = .bottom
        case (.bottom, .out):
            container?.alpha = 0.0
            container?.position = .out
        case (.out, .top):
            container?.alpha = 1.0
            let yPosition = -(bounds.height - (bounds.height / 4.0))
            container?.transform = CGAffineTransform(translationX: 0.0, y: yPosition)
            container?.position = .top
        default: ()
        }
    }
    
    private func updateImageViewConstraint(to container: ContainerView?) {
        guard let container = container, let imageViewBottomToTopContainerConstraint = imageViewBottomToTopContainerConstraint, let imageView = imageView else { return }
        removeConstraint(imageViewBottomToTopContainerConstraint)
        self.imageViewBottomToTopContainerConstraint = imageView.bottomAnchor.constraint(equalTo: container.topAnchor, constant: -Constants.padding)
        self.imageViewBottomToTopContainerConstraint?.isActive = true
    }
    
    private func finishForm() {
        delegate?.summary(questions: questions)
        delegate?.userDidResponseForAllQuestions()
    }
}
