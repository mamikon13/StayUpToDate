//
//  Alert.swift
//  Stay up to date
//
//  Created by Mamikon Nikogosyan on 07.04.2020.
//  Copyright © 2020 Mamikon Nikogosyan. All rights reserved.
//

import Foundation


protocol AlertDelegate: class {
    func didReceive(error: Error?)
}
