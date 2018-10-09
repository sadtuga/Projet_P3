//
//  Team.swift
//  Projet_P3
//
//  Created by Marques Lucas on 10/10/2018.
//  Copyright © 2018 Marques Lucas. All rights reserved.
//

import Foundation

class Team {
    private var name: String = ""
    private var wizard: Int = 0
    var stock: [Character] = []
    
    func getName() -> String {
        return name
    }
    func setName(value: String) {
        self.name = value
    }
    
    func nameTeam() {
        var check: Int = 0
        
        while check == 0 {
            if let input = readLine() {
                if input.count == 0 || input == " " {
                    print("Nom incorrect ❌")
                }else {
                    setName(value: input)
                    check = 1
                }
            }
        }
    }
    // creation d'equipe
    private func addCharacter(choice : String, playerInput: String) {
        switch choice {
        case "1" :
            stock.append(Dwarf(name: playerInput))
        case "2" :
            stock.append(Wizard(name: playerInput))
        case "3" :
            stock.append(Tank(name: playerInput))
        case "4" :
            stock.append(Warrior(name: playerInput))
        default :
            print("erreur ce personnage n'existe pas!")
        }
    }
    
    private func choiceCharacter() -> String {
        print("Sélectionner une classe 👤")
        if let input = readLine() {
            if input == "1" || input == "2" || input == "3" || input == "4" {
                return input
            }
        }
        print("La classe saisie n'existe pas! ❌")
        return "ERREUR"
    }
    
    private func isWizard(input: String) -> Bool {
        if input == "2" && wizard >= 1 {
            print("\nVous possédez déjà un prêtre❗️\n")
            return true
        }else if input == "2" && wizard < 1 {
            wizard += 1
        }
        return false
    }
    
    private func nameCharater() -> String {
        print("Nommer votre combattant! ✍️")
        if let input = readLine() {
            return input
        }
        return "ERREUR"
    }
    
    private func verifyName(name: String, team: Team) -> Bool {
        var converted: String = ""
        
        converted = name.lowercased()
        
        for i in 0 ..< stock.count {
            if converted == stock[i].name {
                print("Le nom saisi est deja pris ❌")
                return true
            }
        }
        for y in 0 ..< team.stock.count {
            if converted == team.stock[y].name {
                print("Le nom saisi est deja pris ❌")
                return true
            }
        }
        return false
    }
    
    func selectCharacter(team: Team) {
        var inputName: String = ""
        var inputClass: String = ""
        var test: Bool = true
        
        print("Les classe disponnible sont: 1. Nain" +
            "\n                             2. Magicien" +
            "\n                             3. Tank" +
            "\n                             4. Guerrier")
        
        while stock.count < 3 {
            while inputClass == "" || inputClass == "Erreur" || test == true {
                inputClass = choiceCharacter()
                if inputClass == "2" {
                    test = isWizard(input: inputClass)
                }else if inputClass == "1" || inputClass == "3" || inputClass == "4" {
                    test = false
                }
            }
            test = true
            while inputName == "" || inputName == "Erreur" || test == true {
                inputName = nameCharater()
                test = verifyName(name: inputName, team: team)
            }
            test = true
            addCharacter(choice: inputClass, playerInput: inputName)
        }
    }
    
}
