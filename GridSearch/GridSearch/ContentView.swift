//
//  ContentView.swift
//  GridSearch
//
//  Created by 阮迅 on 2021-10-14.
//

import SwiftUI

/*
 {
 "artistName": "Justin Bieber",
 "id": "1561058084",
 "name": "Justice (Triple Chucks Deluxe / Deluxe Video Version)",
 "releaseDate": "2021-04-02",
 "kind": "albums",
 "artistId": "320569549",
 "artistUrl": "https://music.apple.com/cn/artist/justin-bieber/320569549",
 "contentAdvisoryRating": "Explict",
 "artworkUrl100": "https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/21/09/f4/2109f4a0-3700-93b3-c678-fd98b2762098/21UMGIM20642.rgb.jpg/100x100bb.jpg",
 "genres": [
 {
 "genreId": "14",
 "name": "国际流行",
 "url": "https://itunes.apple.com/cn/genre/id14"
 },
 {
 "genreId": "34",
 "name": "音乐",
 "url": "https://itunes.apple.com/cn/genre/id34"
 }
 ],
 "url": "https://music.apple.com/cn/album/justice-triple-chucks-deluxe-deluxe-video-version/1561058084"
 }
 
 */

struct Rss: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let results: [Result]
}

struct Result: Decodable, Hashable {
    let name, artistName, artworkUrl100: String
}


class GridViewModel: ObservableObject {
    @Published var results: [Result] = []
    
    init() {
        // MARK: Load Data
        guard let url = URL(string: "https://rss.applemarketingtools.com/api/v2/cn/music/most-played/50/songs.json") else {
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            if let rss = try? JSONDecoder().decode(Rss.self, from: data) {
                self.results = rss.feed.results
            }
            else {
                print("wrong")
            }
            
        }.resume()
    }
}



struct ContentView: View {
    @ObservedObject var gridViewModel: GridViewModel = GridViewModel()
    var artworkImage: UIImage?
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [
                    // MARK: First Way to align the grid item
                    GridItem(.adaptive(minimum: 100, maximum: 200), spacing: 12 ,alignment: .top)
                ], spacing: 12) {
                    
                    ForEach(gridViewModel.results, id: \.self) { result in
                        VStack(alignment: .leading) {
                            if let imageUrl = URL(string: result.artworkUrl100),
                               let data = try? Data(contentsOf: imageUrl),
                               let artworkImage = UIImage(data: data)
                            {
                                Image(uiImage: artworkImage)
                                    .resizable()
                                    .scaledToFit()
//                                    .frame(width: 100, height: 100)
                                    .cornerRadius(22)
                            }
                            else {  // If something is wrong with loading the result from JSON, put in a placeholder
                                Spacer()
                                    .frame(width: 100, height: 100)
                                    .background(Color.blue)
                            }
                            Text(result.name).font(.system(size: 10, weight: .semibold))
//                                .lineLimit(1) MARK: Second Way to align the grid item is to make them the same height (Do it when the content is not important)
                            Text(result.artistName).font(.system(size: 9, weight: .regular))
//                            Text("Release Date").font(.system(size: 8)).foregroundColor(.gray)
                        }
                        .padding([.horizontal], 10)
                        
                    }
                    
                    
                }
            }
            
            
            .navigationTitle("Grid Search")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
