//
//  RoundedCornerView.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 09.05.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//

import UIKit


@IBDesignable class RoundedCornerView: UIView {

    @IBInspectable var fillColor: UIColor = .red

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let borderPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius)
        fillColor.set()
        borderPath.fill()
    }

}
