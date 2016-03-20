//
//  MaterialTextField.swift
//  theShowCase
//
//  Created by Christopher Rathnam on 3/19/16.
//  Copyright © 2016 Christopher Rathnam. All rights reserved.
//

import UIKit

@IBDesignable
class MaterialTextField: UITextField {

    @IBInspectable var inset: CGFloat = 0
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            setupView()
        }
    }
    
    
    
    override func awakeFromNib() {
        setupView()
    }
    
    //For placeholder
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, inset, inset)
    }
    
    //for Editable text
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return textRectForBounds(bounds)
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
        layer.borderColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        layer.borderWidth = borderWidth
    }

}
