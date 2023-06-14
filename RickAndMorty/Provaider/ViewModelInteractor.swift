//
//  ViewModelInteractor.swift
//  RickAndMorty
//
//  Created by NEORIS on 15/6/23.
//

import Foundation

struct ViewModelProvaider {
    static func viewModelListCharacter() -> CharacterListViewModel {
        return CharacterListViewModel(characterInteractor: InteractorProvaider.getCharactersInteractor())
    }
}
