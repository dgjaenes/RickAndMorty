//
//  CharacterListViewModel.swift
//  RickAndMorty
//

import Foundation
import Combine

final class CharacterListViewModel: ObservableObject {
    
    @Published var characters = [CharacterDO]()
    @Published var isLoading = false
    @Published var currentPage = 1
    @Published var totalPages = 1
    lazy var cancellables = Set<AnyCancellable>()
    private var characterInteractor : CharacterInteractorProtocol
    
    init(characterInteractor: CharacterInteractorProtocol) {
        self.characterInteractor = characterInteractor
    }
    
    func loadAllPages() {
        DispatchQueue.main.async {
            self.isLoading = false
        }
        characterInteractor.getCharacters(page: currentPage)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                switch completion {
                case .failure(let error):
                    debugPrint("Error loading page: \(self.currentPage) with error: \(error)")
                case .finished:
                    DispatchQueue.main.async {
                        self.currentPage += 1
                    }
                    if self.currentPage <= self.totalPages {
                        self.loadAllPages()
                    }
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.characters.append(contentsOf: response.results)
                    self.totalPages = response.info.pages
                }
            })
            .store(in: &cancellables)
    }
}

