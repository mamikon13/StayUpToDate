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
    ///
    /// - Parameters:
    ///   - index: The current index the fetch will execute with.
    ///   - handler: The handler for error. In this closure you can capture an error.
    func executeFetch(by index: Int, handler: @escaping (Error?) -> ())

}


protocol FetchCancellable: class {
    
    /// Cancels a fetch by the given index.
    ///
    /// - Parameters:
    ///   - index: The current index the fetch will cancel with.
    func cancelFetch(by index: Int)

}
