//
//  BaseTableViewCell.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 07.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//

import UIKit


protocol BaseTableViewCell: UITableViewCell {
    
    associatedtype Element: Decodable
    
    static var nib: UINib { get }
    
    static var identifier: String { get }
    
    /// Setups a cell by the given object.
    func setupCell(with object: Element)
    
    /// Resets a cell.
    func resetCell()
    
}


extension BaseTableViewCell {
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func resetCell() { }
    
}
