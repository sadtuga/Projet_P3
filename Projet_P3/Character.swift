//
//  Character.swift
//  Projet_P3
//
//  Created by Marques Lucas on 10/10/2018.
//  Copyright © 2018 Marques Lucas. All rights reserved.
//

import Foundation

// Class representing a character
class Character {
    
    var hp: Int // Represents the character's life point
    var life: Bool = true // Is equal to true if the character is alive and false if he is dead
    var maxHP: Int // Represents the maximum number of life points of the character
    var name: String // Stock the name of the character
    var species: String // stock the character class
    var weapon: Weapons // stock the character's weapon
    
    // Initializes the parameters of the class
    init(name: String, hp: Int, species: String, weapon: Weapons) {
        self.name = name
        self.hp = hp
        self.species = species
        self.weapon = weapon
        maxHP = hp
    }
    
    // Call the dodge method and if it returns false the target suffered damage otherwise nothing happens
    func attack(target: Character) -> Bool {
        if dodge() == false {
            target.hp -= self.weapon.power
            return false
        } else {
            print(target.name + " esquive l'attaque! 🤪\n")
            return true
        }
    }
    
    // Returns true if the variable rand is between 0 and 20
    private func dodge() -> Bool {
        let rand: UInt32 = arc4random_uniform(100)
        if rand >= 0 && rand <= 20 {
            return true
        } else {
            return false
        }
    }
    
    // Increases the HP of the target
    func healing(target: Character) {
        let healing: Int = weapon.power
        if target.hp + healing >= target.maxHP {
            target.hp = target.maxHP
        } else {
            target.hp += healing
        }
    }
    
    // Returns 0 if the target is alive and returns 1 otherwise
    func die() -> Int {
        if self.hp <= 0 {
            self.hp = 0
            self.life = false
            print(self.name + " est mort ☠️\n")
            return 1
        }
        return 0
    }

}
