//
//  Address-Swift.swift
//  Xode 9 Demo
//
//  Created by Cain Luo on 2017/11/3.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

import UIKit

class Address_Swift: NSObject {
    
    private func getAddressWithMap(latitudeTextField:UITextField) {
        
        let address: String = "中国北京市通州"
        let latitude: Double = Double(latitudeTextField.text ?? "") ?? 0
        
        print(address, latitude)
        
        if let longitude = Double(latitudeTextField.text ?? "") {
            
            print(longitude)
        }
        
        let latitudeString = (latitudeTextField.text == "1") ? "100" : "23"
        
        print(latitudeString)
    }
}

struct Person {
    
    let name: String
    let height: Double
    
    init(name: String, height: Double) {
        
        self.name = name
        self.height = height
    }
}

extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
}
