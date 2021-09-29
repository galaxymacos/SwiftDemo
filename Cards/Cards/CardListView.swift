//
//  CardListView.swift
//  Cards
//
//  Created by 阮迅 on 2021-09-29.
//

import SwiftUI

struct CardListView: View {
    
    @EnvironmentObject var viewState: ViewState
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(1..<10) { _ in
                    CardThumbnailView()
                        .onTapGesture {
                            viewState.showAllCards.toggle()
                        }
                }
            }
        }
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView()
            .environmentObject(ViewState())
    }
}


