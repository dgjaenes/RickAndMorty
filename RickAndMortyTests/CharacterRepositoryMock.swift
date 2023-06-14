//
//  CharacterRepositoryMock.swift
//  RickAndMortyTests
//
//  Created by NEORIS on 14/6/23.
//

import Foundation
@testable import RickAndMorty
import Combine

class CharacterRepositoryMock: CharacterRepository {
    
    let mockRepository = ManagerAppRepositoryMock.shared
    
    override func execute<T>(components: URLComponents) -> AnyPublisher<T, RAMAppError> where T: Decodable {
        return mockRepository.execute(components: components)
    }
}
