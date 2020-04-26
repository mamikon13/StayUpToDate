//
//  EntityConvertible.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 26.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//

import Foundation


protocol EntityConvertible {
    
    associatedtype Entity
    
    func toEntity() -> Entity?
    
}
