//
//  CharacterRepository.swift
//  RickAndMorty
//

import Foundation
import Combine

protocol CharacterRepositoryProtocol {
    func getCharacter(id: String) -> AnyPublisher<CharacterDO, RAMAppError>
    func getCharacters(page: Int?) -> AnyPublisher<CharacterListDO, RAMAppError>
}

class CharacterRepository: ManagerRAMAppRepository, CharacterRepositoryProtocol {
    
    struct TransactionsAPI {
        static let scheme = "https"
        static let host = "rickandmortyapi.com"
        static let path = "/api/character/"
    }
    
    func getCharacter(id: String) -> AnyPublisher<CharacterDO, RAMAppError> {
        return execute(components: makeUrltComponents(id: id))
    }
    
    func getCharacters(page: Int?) -> AnyPublisher<CharacterListDO, RAMAppError> {
        return execute(components: makeUrltComponents())
    }
    
    func makeUrltComponents(id: String? = nil, page: Int? = nil) -> URLComponents {
        var components = URLComponents()
        components.scheme = TransactionsAPI.scheme
        components.host = TransactionsAPI.host
        components.path = "\(TransactionsAPI.path)\(id ?? "")"
        if let id = id {
            components.path = "\(TransactionsAPI.path)\(id)"
        }
        else if let page = page {
            components.path = "\(TransactionsAPI.path)?page=\(page)"
        }
        
        return components
    }
}

