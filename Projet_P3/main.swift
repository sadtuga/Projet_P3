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

print("Jouer 1 saisissez votre nom : ", terminator: "")
team1.nameTeam()

repeat {
    print("\nJouer 2 saisissez votre nom : ", terminator: "")
    team2.nameTeam()
    
    if team2.getName() == team1.getName() {
        print("Vous ne pouvez pas avoir le même nom que votre adversaire❗️")
    }
} while team2.getName() == team1.getName()

