//
//  Dwarf.swift
//  Projet_P3
//
//  Created by Marques Lucas on 10/10/2018.
//  Copyright © 2018 Marques Lucas. All rights reserved.
//

import Foundation

// Dwarf class with its initializer
class Dwarf: Character {
    
    init(name: String) {
        super.init(name: name, hp: 150, species: "Nain", weapon: Axe(), isWizard: nil)
    }
}
