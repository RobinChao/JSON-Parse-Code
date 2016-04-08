//: Playground - noun: a place where people can play

import Foundation


// Parse this JSON
let json: [String : Any] = [
    "name" : "Magic",
    "age" : 26,
    "mobile" : "87654321"
]

// into this Model object
struct Person {
    let name: String
    let age: Int
    let mobile: String
}

print(Person.init.dynamicType)

// Currying

func makePerson(name: String) -> (age: Int) -> (mobile: String) -> Person {
    
    return { (age: Int) -> (mobile: String) -> Person in
        return { (mobile: String) -> Person in
            return Person(name: name, age: age, mobile: mobile)
        }
    }
}

print(makePerson.dynamicType)
//输出： String -> Int -> String -> Person

print(makePerson("Magic").dynamicType)
//输出：Int -> String -> Person

print(makePerson("Magic")(age: 33).dynamicType)
//输出：String -> Person

print(makePerson("Magic")(age: 33)(mobile: "89898989").dynamicType)
//输出：Person



func parse1(json: [String : Any]) -> Person? {
    guard let name = json["name"] as? String else {
        return .None
    }
    
    guard let age = json["age"] as? Int else {
        return .None
    }
    
    guard let mobile = json["mobile"] as? String else {
        return .None
    }
    
    return Person(name: name, age: age, mobile: mobile)
}

print(parse1(json))


func number(json: [String : Any], key: String) -> Int? {
    return json[key] as? Int
}

func string(json: [String : Any], key: String) -> String? {
    return json[key] as? String
}

func parse2(json: [String : Any]) -> Person? {
    guard let name = string(json, key: "name") else {
        return .None
    }
    
    guard let age = number(json, key: "age") else {
        return .None
    }
    
    guard let mobile = string(json, key: "mobile") else {
        return .None
    }
    
    return Person(name: name, age: age, mobile: mobile)
}

print(parse2(json))





func get<T>(json: [String : Any], key: String) -> T? {
    return json[key] as? T
}

func parse3(json: [String : Any]) -> Person? {
    guard let name: String = get(json, key: "name") else {
        return .None
    }
    
    guard let age: Int = get(json, key: "age") else {
        return .None
    }
    
    guard let mobile: String = get(json, key: "mobile") else {
        return .None
    }
    
    return Person(name: name, age: age, mobile: mobile)
}


print(parse3(json))




func parse4(json: [String : Any]) -> Person? {
    let pName: String? = get(json, key: "name")
    let pAge: Int? = get(json, key: "age")
    let pMobile: String? = get(json, key: "mobile")
    
    let intermediate: (Int) -> (String) -> Person
    let intermediateT: (String) -> Person
    
    if let name = pName {
        intermediate = makePerson(name)
    } else {
        return .None
    }
    
    if let age = pAge {
        intermediateT = intermediate(age)
    } else {
        return .None
    }
    
    if let mobile = pMobile {
        return intermediateT(mobile)
    } else {
        return .None
    }
}


print(parse4(json))






//: JSON 数据解析第一步，最终代码


infix operator <*> {
    associativity left
    precedence 100
}//左结合的left，优先级为100

func <*><A, B>(f: (A -> B)?, x: A?) -> B? {
    guard let f = f, x = x else {
        return .None
    }
    return f(x)
}


func filter<T>(json: [String : Any], key: String) -> T? {
    return json[key] as? T
}

func parse5(json: [String : Any]) -> Person? {
    return makePerson <*> filter(json, key: "name")
                      <*> filter(json, key: "age")
                      <*> filter(json, key: "mobile")
}

print(parse5(json))










