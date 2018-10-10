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
    
    func magicChest(character: Character) {
        switch character.species {
        case "Nain":
            print("\nLe nain ramasse Genzaniku une hache légendaire qui inflige \(character.weapon.power) point de dégâts")
            character.weapon = Genzaniku()
        case "Prêtre":
            character.weapon = Ahavarion()
            print("\nLe prêtre ramasse Ahavarion une bâton légendaire qui régénère \(character.weapon.power) point de vie")
        case "Guerrier":
            character.weapon = TrancheCiel()
            print("\nLe guerrier ramasse TrancheCiel une épée légendaire qui inflige \(character.weapon.power) point de dégâts")
        case "Tank":
            character.weapon = Heliophore()
            print("\nLe tank ramasse Héliophore une marteau légendaire qui inflige \(character.weapon.power) point de dégâts")
        default:
            print("\nPas de chance le programme à planté 👾❗️")
        }
    }
    
    func basicWeapon(character: Character) {
        switch character.species {
        case "Nain":
            character.weapon = Axe()
        case "Prêtre":
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
