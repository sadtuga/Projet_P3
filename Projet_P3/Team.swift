//
//  Team.swift
//  Projet_P3
//
//  Created by Marques Lucas on 10/10/2018.
//  Copyright © 2018 Marques Lucas. All rights reserved.
//

import Foundation

// This class manages the team
class Team {
    
    private var name: String = "" // Stock the name of the team
    private var wizard: Int = 0 // Stock the number of team assistant that can not be equal to 1 maximum
    var deadCharacter: Int = 0 // Stock the number of dead character of the team
    var characters: [Character] = [] // Stock the characters of the team
    
    // Returns the name of the team
    func getName() -> String {
        return name
    }
    
    // Stock the value perceived in the variable name
    func setName(value: String) {
        self.name = value
    }
    
    // Check the seizure of the player and give a name to the team
    func nameTeam() {
        var check: Int = 0
        
        while check == 0 {
            if let input = readLine() {
                if input.count == 0 || input == " " {
                    print("Nom incorrect ❌\n")
                    print("Saisissez un nom valide : ", terminator: "")
                }else {
                    setName(value: input)
                    check = 1
                }
            }
        }
    }
    
    // Add a character to the stock character array
    private func addCharacter(choice : String, playerInput: String) {
        switch choice {
        case "1" :
            characters.append(Dwarf(name: playerInput))
        case "2" :
            characters.append(Wizard(name: playerInput))
        case "3" :
            characters.append(Tank(name: playerInput))
        case "4" :
            characters.append(Warrior(name: playerInput))
        default :
            print("erreur, ce personnage n'existe pas!")
        }
    }
    
    // Return the player choice
    private func choiceCharacter() -> String {
        print("Sélectionnez une classe 👤")
        if let input = readLine() {
            if input == "1" || input == "2" || input == "3" || input == "4" {
                return input
            }
        }
        print("La classe saisie n'existe pas! ❌")
        return "ERREUR"
    }
    
    // Check the number of wizard of a team and returns true if there are already
    private func isWizard(input: String) -> Bool {
        if input == "2" && wizard >= 1 {
            print("\nVous possédez déjà un Magicien❗️\n")
            return true
        }else if input == "2" && wizard < 1 {
            wizard += 1
        }
        return false
    }
    
    // Returns the name of the fighter entered by the player
    private func nameCharater() -> String {
        print("Nommez votre combattant! ✍️")
        if let input = readLine() {
            return input
        }
        return "ERREUR"
    }
    
    // Check if the name entered by the player is already taken and returns true if it is taken
    private func verifyName(name: String, team: Team) -> Bool {
        var converted: String = ""
        converted = name.lowercased()

        for i in 0 ..< characters.count {
            if converted == characters[i].name.lowercased() {
                print("Le nom saisi est déjà pris ❌")
                return true
            }
        }
        for y in 0 ..< team.characters.count {
            if converted == team.characters[y].name.lowercased() {
                print("Le nom saisi est déjà pris ❌")
                return true
            }
        }
        return false
    }
    
    // Team building management
    func selectCharacter(team: Team) {
        var inputName: String = ""
        var inputClass: String = ""
        var check: Bool = true
        
        print("Les classes disponnibles sont: 1. Nain" +
            "\n                               2. Magicien" +
            "\n                               3. Tank" +
            "\n                               4. Guerrier")
        
        while characters.count < 3 {
            while inputClass == "" || inputClass == "Erreur" || check == true {
                inputClass = choiceCharacter()
                if inputClass == "2" {
                    check = isWizard(input: inputClass)
                }else if inputClass == "1" || inputClass == "3" || inputClass == "4" {
                    check = false
                }
            }
            check = true
            while inputName == "" || inputName == "Erreur" || check == true {
                inputName = nameCharater()
                check = verifyName(name: inputName, team: team)
            }
            check = true
            addCharacter(choice: inputClass, playerInput: inputName)
        }
    }
    
}
