//
//  CharacterListView.swift
//  RickAndMorty
//

import SwiftUI

struct CharacterListView: View {

    @StateObject var viewModel = CharacterListViewModel(characterInteractor: CharacterInteractor(characterRepository: CharacterRepository()))
    var body: some View {
        NavigationView {
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

    private func loadAllData() {
        viewModel.loadAllPages()
    }
}