//
//  Display.swift
//  Projet_P3
//
//  Created by Marques Lucas on 11/10/2018.
//  Copyright © 2018 Marques Lucas. All rights reserved.
//

import Foundation

class Display {
    
    private func padding(chain: String, lenght: Int) -> String {
        let padded = chain.padding(toLength: lenght, withPad: " ", startingAt: 0)
        return padded
    }
    
    func displayRound(round: Int) {
        print("+----------------------------------------------------+")
        print(padding(chain: "|                 Round numéro \(round)", lenght: 53) + "|")
        print("+----------------------------------------------------+\n")
    }
    
    private func convertInString(value: Int) -> String {
        let temp: Int = value
        let str: String = String(temp)
        if value < 100 && value > 0 {
            return str + " "
        }else if value == 0 {
            return "⚰️ "
        }
        return str
    }
    
    func displayTeam(team: Team) {
        let space: String = padding(chain: "", lenght: 10)
        var str: String = ""
        
        print("\n+-------------------------------------------------+")
        print(padding(chain: "|         composition de l'équipe \(team.getName)", lenght: 50) + "|")
        print("+-------------------------------------------------+\n")
        print("  Nom            Classe         PV         dégats\n")
        
        for i in 0 ..< team.stock.count {
            str = convertInString(value: team.stock[i].hp)
            print("\(i + 1)." + padding(chain: team.stock[i].name, lenght: 15) + padding(chain: team.stock[i].species, lenght: 15) + str + space + "\(team.stock[i].weapon.power)")
        }
    }
}
