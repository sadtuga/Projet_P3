//
//  Game.swift
//  Projet_P3
//
//  Created by Marques Lucas on 10/10/2018.
//  Copyright © 2018 Marques Lucas. All rights reserved.
//

import Foundation

class Game {
    
    private func isAlive(character: Character) -> Bool {
        if character.life == false {
            print("Le personnage saisi est mort il faut en choisir un autre! ⚰️")
            return false
        }else {
            return true
        }
    }
    
    private func selectFighter(input: String, stock: [Character]) -> Int {
        if let index = Int(input) {
            if isAlive(character: stock[index-1]) == true {
                return index-1
                
            }else {
                return -1
            }
        }else {
            return -1
        }
    }
    
    private func needHealing(stock: [Character]) -> Bool {
        var cpt: Int = 0
        for i in 0 ..< stock.count {
            if stock[i].hp < stock[i].maxHP {
                cpt += 1
            }
        }
        if cpt > 0 {
            return true
        }
        return false
    }
    
    private func readInput() -> String {
        if let str = readLine() {
            return str
        }else {
            return "ERREUR"
        }
    }
    
    private func healing(stock: [Character]) -> Int {
        var check: Bool = false
        var input: String = ""
        print("\nSélectionner une cible parmi les membres de votre équipe pour le soigner 💊")
        input = readInput()
        while check == false {
            if let index = Int(input) {
                if stock[index-1].species == "Magicien" {
                    print("\nVous ne pouviez pas vous soigner vous-même ⛔️")
                    print("\nSélectionner une cible parmi les membres de votre équipe pour le soigner 💊")
                    input = readInput()
                }else if stock[index-1].hp == stock[index-1].maxHP && stock[index-1].species != "Magicien" {
                    print("\nLa santé de " + stock[index-1].name + " est au max sélectionner un autre personnage 🔄")
                    print("\nSélectionner une cible parmi les membres de votre équipe pour le soigner 💊")
                    input = readInput()
                }else if stock[index-1].hp != stock[index-1].maxHP && stock[index-1].species != "Magicien" {
                    check = true
                    return index-1
                }
            }
        }
    }
    
    func fight(teamAttacker: Team, teamTarget: Team) {
        var input: String = ""
        var check: Bool = false
        var dodge: Bool = false
        var indexA: Int = 0
        var indexB: Int = 0
        
        while check == false {
            print("\nSélectionner un combattant 🗡")
            if let input: String = readLine() {
                indexA = selectFighter(input: input, stock: teamAttacker.stock)
                if indexA != -1 && indexA != 1 {
                    check = true
                }else if indexA == 1 && needHealing(stock: teamAttacker.stock) == true {
                    check = true
                }else if indexA == 1 && needHealing(stock: teamAttacker.stock) == false {
                    print("votre equipe na pas besoin de soins ⛔️\n")
                    check = false
                }
            }
        }
        check = false
        let fighter: Character = teamAttacker.stock[indexA]
        
        var target: Character
            while check == false {
                    if fighter.species != "Magicien" {
                        print("\nSélectionner une cible 🎯")
                        input = readInput()
                        indexB = selectFighter(input: input, stock: teamTarget.stock)
                    }else if fighter.species == "Magicien" {
                        indexB = healing(stock: teamAttacker.stock)
                    }
                    if indexB == -1 {
                        check = false
                    }else {
                        check = true
                    }
            }

        if fighter.species == "Magicien" {
            target = teamAttacker.stock[indexB]
            fighter.healing(target: target)
            print("\n" + fighter.name + " à soigner " + target.name + " qui a maintenant " + String(target.hp) + " points de vie ❤️\n")
        }else if fighter.species != "Magicien" {
            target = teamTarget.stock[indexB]
            dodge = fighter.attack(target: target)
            if dodge == false {
                print("\n" + fighter.name + " à attaquer " + target.name + " qui a perdu " + String(fighter.weapon.power) + " points de vie 💔\n")
                teamTarget.deadCharacter += target.die()
            }
        }

    }
    
    private func forfeit(team: Team) -> Bool{
        for i in 0 ..< team.stock.count {
            if team.stock[i].species == "Magicien" && team.stock[i].hp > 0 {
                print("\nl'équipe " + team.getName() + " d'éclare forfait\n")
                return true
            }
        }
        return false
    }
    
    func endGame(team1: Team, team2: Team) -> Bool {
        if team1.deadCharacter == 3 {
            print("\n🎉 Victoire de \(team2.getName()) 🎉")
            return true
        }else if team1.deadCharacter == 2 {
            return forfeit(team: team1)
        }else if team2.deadCharacter == 3 {
            print("\n🎉 Victoire de \(team1.getName()) 🎉")
            return true
        }else if team2.deadCharacter == 2 {
            return forfeit(team: team2)
        }
        return false
    }
    
}
