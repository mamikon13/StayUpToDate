//
//  ManagedObjectConvertible.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 26.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//

import Foundation


protocol ManagedObjectConvertible {
    
    associatedtype ManagedObject: EntityConvertible
    
    func toManagedObject() -> ManagedObject?
    
}
