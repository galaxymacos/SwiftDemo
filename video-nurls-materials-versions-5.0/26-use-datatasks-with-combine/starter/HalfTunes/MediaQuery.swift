//
//  MediaQuery.swift
//  HalfTunes
//
//  Created by 阮迅 on 2021/8/28.
//  Copyright © 2021 raywenderlich. All rights reserved.
//

import Foundation
import Combine

class MediaQuery: ObservableObject {
    
    @Published var itunesQuery = ""
    @Published var searchResults: [MusicItem] = []
    var subscriptions: Set<AnyCancellable> = []
    
    init() {
        $itunesQuery
            .debounce(for: .milliseconds(700), scheduler: RunLoop.main) // MARK: receive the published value in certain amount of time
            .removeDuplicates() // MARK: don't receive the published value if the values are the same
            .compactMap{ query in
                let searchUrl = "http://itunes.apple.com/search?media=music&entity=song&term=\(query)"
                return URL(string: searchUrl)
            }
            .flatMap(fetchMusic)
            .receive(on: DispatchQueue.main)    // We want to get the result to update our UI
            .assign(to: \.searchResults, on: self)
            .store(in: &subscriptions)
    }
    
    func fetchMusic(for url: URL) -> AnyPublisher<[MusicItem], Never> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MediaResponse.self, decoder: JSONDecoder())
            .map(\.results)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
