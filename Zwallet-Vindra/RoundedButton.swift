//
//  RoundedButton.swift
//  Zwallet-Vindra
//
//  Created by Samudra Putra on 12/08/23.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            update()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        update()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        update()
    }
    func update() {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}
