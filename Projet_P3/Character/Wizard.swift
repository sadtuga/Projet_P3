//
//  Wizard.swift
//  Projet_P3
//
//  Created by Marques Lucas on 10/10/2018.
//  Copyright © 2018 Marques Lucas. All rights reserved.
//

import Foundation

// Wizard class with its initializer
class Wizard: Character {
    
    init(name: String) {
        super.init(name: name, hp: 100, species: "Magicien", weapon: Stick())
    }
    
    // Increases the HP of the target
    override func attack(target: Character) {
        let healing: Int = weapon.power
        if target.hp + healing >= target.maxHP {
            target.hp = target.maxHP
        } else {
            target.hp += healing
        }
    }
}
