//
//  main.swift
//  MagicJSON
//
//  Created by Robin on 4/8/16.
//  Copyright © 2016 Robin. All rights reserved.
//

import Foundation 


func parseGender(gender: String) -> Gender {
    switch gender {
    case "male":
        return .Male
    case "female":
        return .Female
    default:
        return .UnKnown
    }
}

func parseName(data: [String : AnyObject]) -> String? {
    return ["first_name", "last_name"].map{ data[$0] as? String }
                                      .flatMap { $0 }
                                      .joinWithSeparator(", ")
}


func parseAddress(data: [String : AnyObject]) -> Address? {
    return makeAddress <*> filter(data, key: "street")
                       <*> filter(data, key: "city")
                       <*> filter(data, key: "state")
}




func parseCustomer(data: [String : AnyObject]) -> Customer? {
    return makeCustomer <*> filter(data, key: "name") <~~ parseName
                        <*> filter(data, key: "age")
                        <*> filter(data, key: "gender") <~~ parseGender
                        <?> filter(data, key: "address") <~~ parseAddress
                        <*> filter(data, key: "skills")
}








