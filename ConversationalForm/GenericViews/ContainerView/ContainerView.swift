//
//  ContainerView.swift
//  ConversationalFormExample
//
//  Created by Marcin Jackowski on 12/11/2018.
//  Copyright © 2018 Marcin Jackowski. All rights reserved.
//

import UIKit

enum ContainerViewPosition {
    case bottom
    case top
    case out
}

final class ContainerView: UIView {
    
    var bottomConstraint: NSLayoutConstraint?
    var tapHandler: (() -> ())?
    var position: ContainerViewPosition = .out {
        didSet {
            updateTouchGesture()
        }
    }

    private var currentView: FormView?
    
    func add(view: FormView) {
        removeView()
        insertSubview(view, at: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        currentView = view
    }
    
    private func removeView() {
        currentView?.removeFromSuperview()
        currentView = nil
    }
    
    private func updateTouchGesture() {
        if position == .top {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ContainerView.viewTapped))
            self.addGestureRecognizer(tapGesture)
        } else {
            self.gestureRecognizers = nil
        }
    }
    
    @objc private func viewTapped() {
        tapHandler?()
    }

    func animateIn() {
        currentView?.animateIn()
    }
    
    func animateOut() {
        currentView?.animateOut()
    }
}
