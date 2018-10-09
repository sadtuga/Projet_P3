//
//  Warrior.swift
//  Projet_P3
//
//  Created by Marques Lucas on 10/10/2018.
//  Copyright © 2018 Marques Lucas. All rights reserved.
//

import Foundation

class Warrior: Character {
    init(name: String) {
        super.init(name: name, hp: 170, species: "Guerrier", weapon: Sword())
    }
}
