//
//  Weapon.swift
//  Projet_P3
//
//  Created by Marques Lucas on 10/10/2018.
//  Copyright © 2018 Marques Lucas. All rights reserved.
//

import Foundation

class Weapons {
    var power: Int = 0
    var name: String = ""
    
    init(name: String, power: Int) {
        self.name = name
        self.power = power
    }
}
