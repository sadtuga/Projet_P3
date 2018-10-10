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

var team1: Team = Team()
var team2: Team = Team()
var game: Game = Game()

print("Jouer 1 saisissez votre nom : ", terminator: "")
team1.nameTeam()

repeat {
    print("\nJouer 2 saisissez votre nom : ", terminator: "")
    team2.nameTeam()
    
    if team2.getName() == team1.getName() {
        print("Vous ne pouvez pas avoir le même nom que votre adversaire❗️")
    }
} while team2.getName() == team1.getName()

print("+---------------------------------------------------+")
print("|              👥 Création d'équipe 👥              |")
print("+---------------------------------------------------+\n")

print("\n\(team1.getName()) composé votre équipe\n")
team1.selectCharacter(team: team2)

print("\n\(team2.getName()) composé votre équipe\n")
team2.selectCharacter(team: team1)

print("+----------------------------------------------------+")
print("|               ⚔️ Début du combat! ⚔️               |")
print("+----------------------------------------------------+\n")

var teamAttacker: Team = team1
var teamTarget: Team = team2
var rand: UInt32 = arc4random_uniform(100)

print("🎲Le hasard décidera de qui portera le premier coup!🎲\n")

if rand % 2 == 1 {
    teamAttacker = team1
    teamTarget = team2
}else if rand % 2 == 0 {
    teamAttacker = team2
    teamTarget = team1
}
while 1 == 1 {
    teamAttacker.displayTeam()
    teamTarget.displayTeam()
    game.fight(teamAttacker: teamAttacker, teamTarget: teamTarget)
    swap(&teamAttacker, &teamTarget)// switch roles
    print("Appuyez sur une touche pour continuer!\n")
    if readLine() != nil {}
}
