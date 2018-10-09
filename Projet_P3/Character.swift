//
//  Character.swift
//  Projet_P3
//
//  Created by Marques Lucas on 10/10/2018.
//  Copyright © 2018 Marques Lucas. All rights reserved.
//

import Foundation

class Character {
    var hp: Int
    var name: String
    var species: String
    var weapon: Weapons
    
    init(name: String, hp: Int, species: String, weapon: Weapons) {
        self.name = name
        self.hp = hp
        self.species = species
        self.weapon = weapon
    }
}
