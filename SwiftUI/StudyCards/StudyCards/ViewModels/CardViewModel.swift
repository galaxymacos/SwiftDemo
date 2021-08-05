//
//  CardViewModel.swift
//  StudyCards
//
//  Created by Xun Ruan on 2021/7/23.
//

import Combine

final class CardViewModel: ObservableObject, Identifiable{
    var cardRepository = CardRepository()
    @Published var studyCard: StudyCard
    
    var id = ""
    
    var cancelables: Set<AnyCancellable> = []
    init(studyCard: StudyCard) {
        self.studyCard = studyCard
        $studyCard
            .compactMap{$0.id}
            .assign(to: \.id, on: self)
            .store(in: &cancelables)
    }
}
