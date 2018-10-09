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
}
