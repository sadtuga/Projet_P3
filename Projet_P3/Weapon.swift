//
//  Weapon.swift
//  Projet_P3
//
//  Created by Marques Lucas on 10/10/2018.
//  Copyright © 2018 Marques Lucas. All rights reserved.
//

import Foundation

// Class representing a weapon
class Weapons {
    
    var power: Int = 0 // Represents the power of the weapon
    var name: String = "" // Stock the name of the weapon
    
    // Initializes the parameters of the class
    init(name: String, power: Int) {
        self.name = name
        self.power = power
    }
    
    // Equip a legendary weapon with the character according to his class
    func magicChest(character: Character) {
        switch character.species {
        case "Nain":
            print("\nLe nain ramasse Genzaniku une hache légendaire qui inflige ", terminator: "")
            character.weapon = Genzaniku()
            print("\(character.weapon.power) points de dégâts")
        case "Magicien":
            print("\nLe prêtre ramasse Ahavarion une bâton légendaire qui régénère ", terminator: "")
            character.weapon = Ahavarion()
            print("\(character.weapon.power) points de vie")
        case "Guerrier":
            print("\nLe guerrier ramasse Tranche-Ciel une épée légendaire qui inflige ", terminator: "")
            character.weapon = TrancheCiel()
            print("\(character.weapon.power) points de dégâts")
        case "Tank":
            print("\nLe tank ramasse Héliophore une marteau légendaire qui inflige ", terminator: "")
            character.weapon = Heliophore()
            print("\(character.weapon.power) points de dégâts")
        default:
            print("\nPas de chance le programme à planté 👾❗️")
        }
    }
    
    // Equip a basic weapon to the character according to his class
    func basicWeapon(character: Character) {
        switch character.species {
        case "Nain":
            character.weapon = Axe()
        case "Magicien":
            character.weapon = Stick()
        case "Guerrier":
            character.weapon = Sword()
        case "Tank":
            character.weapon = Hammer()
        default:
            print("\nPas de chance le programme à planté 👾❗️")
        }
    }
    
}
