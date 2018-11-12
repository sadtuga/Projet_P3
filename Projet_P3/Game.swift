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
            print("Le personnage saisi est mort il faut en choisir un autre! ⚰️")
            return false
        } else {
            return true
        }
    }
    
    // Return the index of the character selected by the player and returns -1 if the input is incorrect
    private func selectFighter(input: String, characters: [Character]) -> Int {
        let index: Int = Int(input)!
        
        if isAlive(character: characters[index-1]) == true {
            return index-1
        } else {
            return -1
        }
    }
    
    // Check if the attacking team's characters need care
    private func needHealing(characters: [Character]) -> Bool {
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

    // Return the character's index if he can receive care
    private func healing(characters: [Character]) -> Int {
        var check: Bool = false
        var index: Int = -1
        
        while check == false {
            print("\nSélectionnez une cible parmi les membres de votre équipe pour le soigner 💊")
            if let input: String = readLine() {
                if input == "1" || input == "2" || input == "3" {
                    index = Int(input)!
                    if characters[index-1].species == "Magicien" {
                        print("\nVous ne pouvez pas vous soigner vous-même ⛔️")
                    } else if characters[index-1].hp == characters[index-1].maxHP && characters[index-1].species != "Magicien" {
                        print("\nLa santé de " + characters[index-1].name + " est au max sélectionner un autre personnage 🔄")
                    } else if characters[index-1].life == false && characters[index-1].species != "Magicien" {
                        print("\n\(characters[index-1].name) est déjà mort vous ne pouvez pas le soigner ⚰️")
                    } else if characters[index-1].hp != characters[index-1].maxHP && characters[index-1].species != "Magicien" {
                        check = true
                        return index-1
                    }
                } else {
                    print("Veuillez choisir un personnage valide.")
                }
            }
        }
    }
    
    // Fight management
    func fight(teamAttacker: Team, teamTarget: Team) {
        var check: Bool = false
        let event: UInt32 = arc4random_uniform(100)
        var indexA: Int = 0
        var indexB: Int = 0
        
        while check == false {
            print("\nSélectionner un combattant 🗡")
            if let input: String = readLine() {
                if input == "1" || input == "2" || input == "3" {
                    indexA = selectFighter(input: input, characters: teamAttacker.characters)
                    if indexA != -1 && indexA != 1 {
                        check = true
                    } else if indexA == 1 && needHealing(characters: teamAttacker.characters) == true {
                        check = true
                    } else if indexA == 1 && needHealing(characters: teamAttacker.characters) == false {
                        print("Votre equipe na pas besoin de soins ⛔️\n")
                        check = false
                    }
                } else {
                    print("Veuillez choisir un personnage valide.")
                }
            }
        }
        check = false
        let fighter: Character = teamAttacker.characters[indexA]
        
        var target: Character
            while check == false {
                    if fighter.species != "Magicien" {
                        print("\nSélectionner une cible 🎯")
                        if let input: String = readLine() {
                            if input == "1" || input == "2" || input == "3" {
                                indexB = selectFighter(input: input, characters: teamTarget.characters)
                            } else {
                                print("Veuillez choisir un personnage valide.")
                                indexB = -1
                            }
                        }
                    } else if fighter.species == "Magicien" {
                        indexB = healing(characters: teamAttacker.characters)
                    }
                    if indexB == -1 {
                        check = false
                    } else {
                        check = true
                    }
            }

        if event >= 15 && event <= 40 {
            fighter.weapon.magicChest(character: fighter)
        }

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
        
        if event >= 15 && event <= 40 {
            fighter.weapon.basicWeapon(character: fighter)
        }
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
