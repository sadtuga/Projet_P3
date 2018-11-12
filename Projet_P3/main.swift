//
//  main.swift
//  Projet_P3
//
//  Created by Marques Lucas on 09/10/2018.
//  Copyright © 2018 Marques Lucas. All rights reserved.
//

import Foundation

print("+---------------------------------------------------+")
print("|               ⚔️ Debut de partie ⚔️               |")
print("+---------------------------------------------------+\n")

// Instance creation
var teamOne: Team = Team()
var teamTwo: Team = Team()
var game: Game = Game()
var display: Display = Display()
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

print("\n\(team2.getName()) composez votre équipe\n")
teamTwo.selectCharacter(team: teamOne)

print("+----------------------------------------------------+")
print("|               ⚔️ Début du combat! ⚔️               |")
print("+----------------------------------------------------+\n")

var teamAttacker: Team = teamOne
var teamTarget: Team = teamTwo
var rand: UInt32 = arc4random_uniform(100)

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
while game.endGame(teamOne: teamAttacker, teamTwo: teamTarget, round: round) == false {
    round += 1
    display.displayRound(round: round)
    display.displayTeam(team: teamAttacker)
    display.displayTeam(team: teamTarget)
    game.fight(teamAttacker: teamAttacker, teamTarget: teamTarget)
    swap(&teamAttacker, &teamTarget)// switch roles
    print("Appuyez sur \"entrée\" pour continuer!\n")
    if readLine() != nil {} // Puts the game in pose while waiting for the player supports on enter
}

