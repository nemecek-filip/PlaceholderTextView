//
//  PlaceholderTextView.swift
//
//  Created by Filip Němeček on 18/07/2019.
//

import UIKit

@IBDesignable final class PlaceholderTextView: UITextView {
    
    @IBInspectable var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    override var text: String! {
        didSet {
            if text.isNilOrEmpty {
                placeholderLabel.isHidden = false
            } else {
                placeholderLabel.isHidden = true
            }
        }
    }
    
    override var font: UIFont? {
        didSet {
            placeholderLabel.font = font
        }
    }
    
    private func customize() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 5
    }
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()
    
    private let placeholderMargins: CGFloat = 6
    
    private func setupView() {
        addSubview(placeholderLabel)
        
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: placeholderMargins),
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: placeholderMargins),
            trailingAnchor.constraint(greaterThanOrEqualTo: placeholderLabel.trailingAnchor, constant: placeholderMargins),
            bottomAnchor.constraint(equalTo: placeholderLabel.bottomAnchor, constant: placeholderMargins)
            ])
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        customize()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customize()
        setupView()
    }
    
    override func becomeFirstResponder() -> Bool {
        placeholderLabel.isHidden = true
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        if text.isNilOrEmpty {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
        return super.resignFirstResponder()
    }
}

private extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        return self == nil || self!.isEmpty
    }
}

