//
//  Operators.swift
//  MagicJSON
//
//  Created by Robin on 4/9/16.
//  Copyright © 2016 Robin. All rights reserved.
//

import Foundation


infix operator <*> {
    associativity left
    precedence 100
} //左结合的left，优先级100

func <*><A, B>(f: (A -> B?)?, x: A?) -> B? {
    guard let f = f, x = x else {
        return .None
    }
    return f(x)
}


infix operator <~~ {
    associativity left
    precedence 110
} //左结合的left，优先级110

func <~~<A, B>(x: A?, f: (A -> B?)) -> B? {
    guard let x = x else {
        return .None
    }
    return f(x)
}


infix operator <<~ {
    associativity left
    precedence 110
} //左结合的left，优先级110

func <<~<A, B>(x: [A]?, f: (A -> B?)) -> [B]? {
    guard let x = x else {
        return nil
    }
    return x.map(f).flatMap{ $0 }
}