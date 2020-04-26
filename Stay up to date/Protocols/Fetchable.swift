//
//  FetchableProtocol.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 06.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//

import Foundation


typealias Fetchable = FetchExecutable & FetchCancellable


protocol FetchExecutable: class {
    
    /// Executes a fetch by the given index.
    func executeFetch(by index: Int, handler: @escaping (Error?) -> ())

}


protocol FetchCancellable: class {
    
    /// Cancels a fetch by the given index.
    func cancelFetch(by index: Int)

}
