//
//  MaterialButton.swift
//  theShowCase
//
//  Created by Christopher Rathnam on 3/19/16.
//  Copyright © 2016 Christopher Rathnam. All rights reserved.
//

import UIKit
import pop

@IBDesignable
class MaterialButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            setUpView()
        }
    }
    
    @IBInspectable var shadowOpacity: CGFloat = 1.0 {
        didSet {
            setUpView()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 5.0 {
        didSet {
            setUpView()
        }
    }
    
    override func awakeFromNib() {
        setUpView()
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }

    func setUpView () {
        
        layer.cornerRadius = cornerRadius
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 5.0
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        
        self.addTarget(self, action: #selector(MaterialButton.scaleToSmall), forControlEvents: .TouchDown)
        self.addTarget(self, action: #selector(MaterialButton.scaleToSmall), forControlEvents: .TouchDragEnter)
        self.addTarget(self, action: #selector(MaterialButton.scaleAnimation), forControlEvents: .TouchUpInside)
        self.addTarget(self, action: #selector(MaterialButton.scaleDefault), forControlEvents: .TouchDragExit)
    }
    
    func scaleToSmall() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(0.80, 0.80))
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleSmallAnimation")
    }
    
    func scaleAnimation() {
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.velocity = NSValue(CGSize: CGSizeMake(3.0, 3.0))
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
        scaleAnim.springBounciness = 20
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleSmallAnimation")
    }
    
    func scaleDefault() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.toValue = NSValue(CGSize: CGSizeMake(1, 1))
        self.layer.pop_addAnimation(scaleAnim, forKey: "layerScaleSmallAnimation")
    }

    
}
