//
//  ContentView.swift
//  StudyCards
//
//  Created by Xun Ruan on 2021/7/23.
//

import SwiftUI

struct CardListView: View {
    @ObservedObject var cardListViewModel: CardListViewModel
    @State var showingForm = false
    @State var showPassed = false
    var body: some View {
        NavigationView{
            VStack{
                Toggle(isOn: $showPassed, label: {
                    Text("\(showPassed ? "Hide" : "Show") pass questions")
                })
                List{
                    ForEach(cardListViewModel.cardViewModels.filter{
                        $0.studyCard.passed == showPassed
                    }){
                        cardVM in
                        CardView(cardViewModel: cardVM)
                            .onLongPressGesture(minimumDuration: 1.5) {
                                var studyCard = cardVM.studyCard
                                studyCard.passed.toggle()
                                cardListViewModel.update(studyCard)
                            }
                    }.onDelete(perform: delete)
                }
                .listStyle(InsetListStyle())
                .navigationTitle("StudyCards")
                
                Button(action: {showingForm = true}){
                    Circle()
                        .fill(Color.green)
                        .frame(height: 60)
                        .overlay(Image(systemName: "plus").foregroundColor(.white))
                }.sheet(isPresented: $showingForm){
                    FormView { studyCard in
                        cardListViewModel.add(studyCard)
                        showingForm = false
                    }
                }
            }
        }
    }
    
    func delete(at offsets: IndexSet){
        offsets.map{cardListViewModel.cardViewModels[$0].studyCard}.forEach(cardListViewModel.remove(_:))
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView(cardListViewModel: CardListViewModel())
    }
}
