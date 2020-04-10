//
//  BaseViewController.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 08.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//

import UIKit


protocol BaseViewController: UIViewController {
    
    static var nib: UINib { get }
    
    static var identifier: String { get }
    
}


extension BaseViewController {
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
