//
//  CardListViewModel.swift
//  StudyCards
//
//  Created by Xun Ruan on 2021/7/23.
//

import Combine

final class CardListViewModel: ObservableObject{
    @Published var cardRepository = CardRepository()
    @Published var cardViewModels: [CardViewModel] = []
    
    private var cancelables: Set<AnyCancellable> = []
    
    init() {
        // assessing the publisher that sends us an array of study cards
        cardRepository.$studyCards
            .map {studyCards in
                studyCards.map(CardViewModel.init)
            }
            .assign(to: \.cardViewModels, on: self)
            .store(in: &cancelables)
    }
    
    func add(_ studyCard: StudyCard){
        cardRepository.add(studyCard)
    }
    
    func remove(_ studyCard: StudyCard){
        cardRepository.delete(studyCard)
    }
    
    func update(_ studyCard: StudyCard){
        cardRepository.update(studyCard)
    }
}
