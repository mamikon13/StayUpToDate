//
//  AnyEntityConvertible.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 05.05.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//

import Foundation


struct AnyEntityConvertible<Entity: ManagedObjectConvertible>: EntityConvertible {
    
    private let _box: _AnyConvertibleBox<Entity>
    
    init<MapperType: EntityConvertible>(_ mapper: MapperType) where MapperType.Entity == Entity {
        _box = _ConvertibleBox(mapper)
    }
    
    func toEntity() -> Entity {
        return _box.toEntity()
    }
    
}


private class _AnyConvertibleBox<Entity: ManagedObjectConvertible>: EntityConvertible {
    
    func toEntity() -> Entity {
        fatalError("This method is abstract")
    }
    
}


private class _ConvertibleBox<Base: EntityConvertible>: _AnyConvertibleBox<Base.Entity> {
    
    private let _base: Base
    
    init(_ base: Base) {
        _base = base
    }
    
    override func toEntity() -> Base.Entity {
        return _base.toEntity()
    }
    
}
