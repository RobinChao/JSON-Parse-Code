//
//  ViewController.swift
//  MagicJSON
//
//  Created by Robin on 4/9/16.
//  Copyright © 2016 Robin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let file = NSBundle.mainBundle().pathForResource("Array_of_customers", ofType: "json")
        print(file)
        
        guard let data = NSData(contentsOfFile: file!),
            let jsonData = try? NSJSONSerialization.JSONObjectWithData(data, options: []) else {
                print("Couldn't load JSON file")
                exit(1)
        }
        
        let customers = filter(jsonData) <<~ parseCustomer
        
        guard let _ = customers else {
            print("Couldn't parse customers data")
            exit(1)
        }
        
        print(customers)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

