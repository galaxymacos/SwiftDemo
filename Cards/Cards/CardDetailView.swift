//
//  CardDetailView.swift
//  Cards
//
//  Created by 阮迅 on 2021-09-29.
//

import SwiftUI

struct CardDetailView: View {
    @EnvironmentObject var viewState: ViewState
    @State var currentModal = CardModel.stickerPicker
    var body: some View {
        Color.yellow
            .toolbar {  // MARK: for toolbar to show up, it needs to be in a NavigationView
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {viewState.showAllCards.toggle()}) {
                        Text("Done")
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    CardBottomToolbar(cardModel: $currentModal)
                }
            }
        
    }
}


struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView()
            .environmentObject(ViewState())
    }
}
