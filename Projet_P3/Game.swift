//
//  Game.swift
//  Projet_P3
//
//  Created by Marques Lucas on 10/10/2018.
//  Copyright © 2018 Marques Lucas. All rights reserved.
//

import Foundation

// The Game class contains all the useful methods in fight
class Game {
    
    func play() {
        
        print("+---------------------------------------------------+")
        print("|               ⚔️ Debut de partie ⚔️               |")
        print("+---------------------------------------------------+\n")
        
        // Instance creation
        let teamOne: Team = Team()
        let teamTwo: Team = Team()
        let display: Display = Display()
        var round: Int = 0
        
        // Assign a name to the team
        print("Joueur 1 saisissez votre nom : ", terminator: "")
        teamOne.nameTeam()
        
        repeat {
            print("\nJoueur 2 saisissez votre nom : ", terminator: "")
            teamTwo.nameTeam()
            
            if teamTwo.getName() == teamOne.getName() {
                print("Vous ne pouvez pas avoir le même nom que votre adversaire❗️")
            }
        } while teamTwo.getName() == teamOne.getName()
        
        print("+---------------------------------------------------+")
        print("|              👥 Création d'équipe 👥              |")
        print("+---------------------------------------------------+\n")
        
        // Team building
        print("\n\(teamOne.getName()) composez votre équipe\n")
        teamOne.selectCharacter(team: teamTwo)
        
        print("\n\(teamTwo.getName()) composez votre équipe\n")
        teamTwo.selectCharacter(team: teamOne)
        
        print("+----------------------------------------------------+")
        print("|               ⚔️ Début du combat! ⚔️               |")
        print("+----------------------------------------------------+\n")
        
        var teamAttacker: Team = teamOne
        var teamTarget: Team = teamTwo
        let rand: UInt32 = arc4random_uniform(100)
        
        print("🎲Le hasard décidera qui portera le premier coup!🎲\n")
        
        // Random role assignment
        if rand % 2 == 1 {
            teamAttacker = teamOne
            teamTarget = teamTwo
        }else if rand % 2 == 0 {
            teamAttacker = teamTwo
            teamTarget = teamOne
        }
        
        // The rest of the game is in this loop
        while endGame(teamOne: teamAttacker, teamTwo: teamTarget, round: round) == false {
            round += 1
            display.displayRound(round: round)
            display.displayTeam(team: teamAttacker)
            display.displayTeam(team: teamTarget)
            fight(teamAttacker: teamAttacker, teamTarget: teamTarget)
            swap(&teamAttacker, &teamTarget)// switch roles
            print("Appuyez sur \"entrée\" pour continuer!\n")
            if readLine() != nil {} // Puts the game in pose while waiting for the player supports on enter
        }
    }
    
    // Check if the received character is alive and returns false if he is dead
    private func isAlive(character: Character) -> Bool {
        if character.life == false {
            return false
        } else {
            return true
        }
    }
    
    // Check if the attacking team's characters need care
    private func needHealing(_ characters: [Character]) -> Bool {
        var cpt: Int = 0
        for i in 0 ..< characters.count {
            if characters[i].hp < characters[i].maxHP && characters[i].life != false && characters[i].species != "Magicien" {
                cpt += 1
            }
        }
        if cpt > 0 {
            return true
        }
        return false
    }
    
    // Returns an integer corresponding to the user input is also checked if the character is dead and the team needs care
    private func readInput(_ characters: [Character], _ healing: Bool?) -> Int {
        let check: Bool = false
        while check == false {
            if let input: String = readLine() {
                if input == "1" || input == "2" || input == "3" {
                    if isAlive(character: characters[Int(input)!-1]) == false {
                        print("Le personnage saisi est mort il faut en choisir un autre! ⚰️")
                        print("Choisissez un autre personnage❗️")
                    } else if characters[Int(input)!-1].species == "Magicien" && healing == false {
                        print("Votre équipe n'a pas besoin de soins ⛔️\n")
                        print("Choisissez un autre personnage❗️")
                    } else {
                        return Int(input)!-1
                    }
                }
            } else {
                print("Veuillez choisir un personnage valide❗️")
            }
        }
    }
    
    // Return the character's index if he can receive care
    private func healing(characters: [Character]) -> Int {
        var check: Bool = false
        var index: Int = -1
        
        while check == false {
            print("\nSélectionnez une cible parmi les membres de votre équipe pour le soigner 💊")
            index = readInput(characters, nil)
            if characters[index].species == "Magicien" {
                print("\nVous ne pouvez pas vous soigner vous-même ⛔️")
            } else if characters[index].hp == characters[index].maxHP && characters[index].species != "Magicien" {
                print("\nLa santé de " + characters[index].name + " est au max sélectionner un autre personnage 🔄")
            } else if characters[index].life == false && characters[index].species != "Magicien" {
                print("\n\(characters[index].name) est déjà mort vous ne pouvez pas le soigner ⚰️")
            } else if characters[index].hp != characters[index].maxHP && characters[index].species != "Magicien" {
                check = true
                return index
            }
        }
    }
    
    // Returns the index of the selected character
    private func selectAttacker(attacker: [Character]) -> Int {
        var heal: Bool = false
        print("\nSélectionner un combattant 🗡")
        heal = needHealing(attacker)
        return readInput(attacker, heal)
    }
    
    // Give a legendary weapon to the attacker
    private func pickUpLegendaryWeapons(_ fighter: Character, _ event: Bool) -> Bool {
        let rand: UInt32 = arc4random_uniform(100)
        if rand >= 15 && rand <= 40 && event == false {
            fighter.weapon.magicChest(character: fighter)
            return true
        } else if event == true {
            fighter.weapon.basicWeapon(character: fighter)
            return false
        } else {
            return false
        }
    }
    
    // Fight management
    private func fightManagement(fighter: Character, teamAttacker: Team, teamTarget: Team, indexB: Int) {
        let target: Character
        if fighter.species == "Magicien" {
            target = teamAttacker.characters[indexB]
            fighter.attack(target: target)
            print("\n" + fighter.name + " à soigner " + target.name + " qui a maintenant " + String(target.hp) + " points de vie ❤️\n")
        } else if fighter.species != "Magicien" {
            target = teamTarget.characters[indexB]
            if target.dodge() != true {
                fighter.attack(target: target)
                print("\n" + fighter.name + " à attaqué " + target.name + " qui a perdu " + String(fighter.weapon.power) + " points de vie 💔\n")
                teamTarget.deadCharacter += target.die()
            }
        }
    }
    
    // manages the course of the fight
    func fight(teamAttacker: Team, teamTarget: Team) {
        var event: Bool = false
        var indexA: Int = 0
        var indexB: Int = 0
        
        indexA = selectAttacker(attacker: teamAttacker.characters)
        let fighter: Character = teamAttacker.characters[indexA]
        
        if fighter.species != "Magicien" {
            print("\nSélectionner une cible 🎯")
            indexB = readInput(teamTarget.characters, nil)
        } else if fighter.species == "Magicien" {
            indexB = healing(characters: teamAttacker.characters)
        }
        
        event = pickUpLegendaryWeapons(fighter, event)
        fightManagement(fighter: fighter, teamAttacker: teamAttacker, teamTarget: teamTarget, indexB: indexB)
        event = pickUpLegendaryWeapons(fighter, event)
    }
    
    // Returns true if the magician is the only survivor
    private func forfeit(team: Team, round: Int) -> Bool{
        for i in 0 ..< team.characters.count {
            if team.characters[i].species == "Magicien" && team.characters[i].hp > 0 {
                print("\n😱 l'équipe " + team.getName() + " d'éclare forfait au round numéro \(round) rounds 😱\n")
                return true
            }
        }
        return false
    }
    
    // returns true if all the characters in a team are dead or if forfeit is true
    func endGame(teamOne: Team, teamTwo: Team, round: Int) -> Bool {
        if teamOne.deadCharacter == 3 {
            print("\n🎉 Victoire de \(teamTwo.getName()) en \(round) rounds 🎉")
            return true
        } else if teamOne.deadCharacter == 2 {
            return forfeit(team: teamOne, round: round)
        } else if teamTwo.deadCharacter == 3 {
            print("\n🎉 Victoire de \(teamOne.getName()) en \(round) rounds 🎉")
            return true
        } else if teamTwo.deadCharacter == 2 {
            return forfeit(team: teamTwo, round: round)
        }
        return false
    }
    
}
