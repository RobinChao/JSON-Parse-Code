//: Playground - noun: a place where people can play

import Foundation


// Parse this JSON
let json: [String : Any] = [
    "name" : "Magic",
    "age" : 26,
    "mobile" : "87654321",
    "is_done" : "yes"
]

// into this Model object
struct Person {
    let name: String
    let age: Int
    let mobile: String
    let isDone: Bool
}

print(Person.init.dynamicType)

// Currying

func makePerson(name: String) -> (age: Int) -> (mobile: String) -> (isDone: Bool) -> Person {
    
    return { age in { mobile in { isDone in
        return  Person(name: name, age: age, mobile: mobile, isDone: isDone)
        }}
    }
}


//: JSON 数据解析第一步，最终代码


infix operator <*> {
    associativity left
    precedence 100
}//左结合的left，优先级为100

infix operator <~~ {
    associativity left
    precedence 110
}//左结合的left，优先级为110

func <*><A, B>(f: (A -> B)?, x: A?) -> B? {
    guard let f = f, x = x else {
        return .None
    }
    return f(x)
}


func <~~<A, B>(x: A?, f: (A -> B?)) -> B? {
    guard let x = x else {
        return .None
    }
    return f(x)
}


func filter<T>(json: [String : Any], key: String) -> T? {
    return json[key] as? T
}

func parseIsDone(value: String) -> Bool? {
    switch value {
    case "yes":
        return true
    case "no":
        return false
    default:
        return .None
    }
}


func parse(json: [String : Any]) -> Person? {
    return makePerson <*> filter(json, key: "name")
                      <*> filter(json, key: "age")
                      <*> filter(json, key: "mobile") <*> filter(json, key: "is_done") <~~ parseIsDone
}

print(parse(json))










