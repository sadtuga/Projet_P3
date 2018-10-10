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
    var life: Bool = true 
    var maxHP: Int
    var name: String
    var species: String
    var weapon: Weapons
    
    init(name: String, hp: Int, species: String, weapon: Weapons) {
        self.name = name
        self.hp = hp
        self.species = species
        self.weapon = weapon
        maxHP = hp
    }
    
    func attack(target: Character) -> Bool {
        if dodge() == false {
            target.hp -= self.weapon.power
            return false
        }else {
            print(target.name + " esquive l'attaque! 🤪\n")
            return true
        }
    }

    private func dodge() -> Bool {
        let rand: UInt32 = arc4random_uniform(100)
        if rand >= 0 && rand <= 20 {
            return true
        }else {
            return false
        }
    }
    
    func healing(target: Character) {
        let healing: Int = weapon.power
        if target.hp + healing >= target.maxHP {
            target.hp = target.maxHP
        }else {
            target.hp += healing
        }
    }
    
    func die() {
        if self.hp <= 0 {
            self.hp = 0
            self.life = false
            print(self.name + " est mort ☠️\n")
        }
    }

}
