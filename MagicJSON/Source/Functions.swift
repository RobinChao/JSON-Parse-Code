//
//  Functions.swift
//  MagicJSON
//
//  Created by Robin on 4/9/16.
//  Copyright © 2016 Robin. All rights reserved.
//

import Foundation


func filter<T>(json: [String : AnyObject], key: String) -> T? {
    return json[key] as? T
}

func filter<T>(item: AnyObject) -> T? {
    return item as? T
}