//
//  CharacterListView.swift
//  RickAndMorty
//

import SwiftUI

struct CharacterListView: View {

    @StateObject var viewModel = CharacterListViewModel(characterInteractor: InteractorProvaider.getCharactersInteractor())
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                searchField
                    .padding(.leading, 20)
                List {
                    Section(header: Text("Characters")) {
                        ForEach(viewModel.characters, id: \.id) { character in
                            NavigationLink(destination: CharacterDetail(character: character)) {
                                CharacterCardView(character: character)
                            }
                            .listRowBackground(Color.black)
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(.white)
                        }
                    }
                }
                .navigationBarTitle(Text("Rick and Morty"))
                .onAppear {
                    loadAllData()
                }
            }
            
        }
    }

    private func loadAllData() {
        viewModel.loadAllPages()
    }
}

private extension CharacterListView {
    
    var searchField: some View {
        HStack(alignment: .center) {
            TextField("example: Morty, , Thanos ...", text: $viewModel.name)
        }
    }
    
    var emptySection: some View {
        Section {
            Text("No results")
                .foregroundColor(.gray)
        }
    }
}
