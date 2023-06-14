//
//  InteractorProvaider.swift
//  RickAndMorty
//
//  Created by NEORIS on 15/6/23.
//

import Foundation

struct InteractorProvaider {
    static func getCharactersInteractor() -> CharacterInteractorProtocol {
        return CharacterInteractor(characterRepository: CharacterRepository())
    }
}
