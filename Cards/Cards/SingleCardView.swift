//
//  SingleCardView.swift
//  Cards
//
//  Created by 阮迅 on 2021-09-29.
//

import SwiftUI

struct SingleCardView: View {
    @EnvironmentObject var viewState: ViewState
    var body: some View {
        NavigationView {
            CardDetailView()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Detail View")
        }
        .navigationViewStyle(.stack)    // MARK: Ensure you only see a single top view at a time
    }
}

struct SingleCardView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCardView()
            .environmentObject(ViewState())
    }
}

