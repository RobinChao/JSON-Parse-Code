//
//  Curries.swift
//  MagicJSON
//
//  Created by Robin on 4/9/16.
//  Copyright © 2016 Robin. All rights reserved.
//

import Foundation


enum Gender {
    case UnKnown, Male, Female
}


struct Address {
    let street: String
    let city: String
    let state: String
}


struct Customer  {
    let name: String //first_name, last_name
    let age: Int
    let gender: Gender
    let address: Address? //may be nil
    let skills: [String]
}

struct Member {
    let memberID: Int
    let name: String
}


//Curried initializers
func makeAddress(street: String) -> (city: String) -> (state: String) -> Address {
    return { city in { state in
        return Address(street: street, city: city, state: state)
        }
    }
}


func makeCustomer(name: String) -> (age: Int) -> (gender: Gender) -> (address: Address?) -> (skills: [String]) -> Customer {
    return { age in { gender in { address in { skills in
        return Customer(name: name, age: age, gender: gender, address: address, skills: skills)
        }}}
    }
}




func makeMember(memberID: Int) -> (name: String) -> Member {
    return { name in
        return Member(memberID: memberID, name: name)
    }
}



