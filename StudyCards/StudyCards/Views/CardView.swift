//
//  CardView.swift
//  StudyCards
//
//  Created by Xun Ruan on 2021/7/23.
//

import SwiftUI

struct CardView: View {
    @State var flipped = false
    let cardViewModel: CardViewModel
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(flipped ? Color.white: Color.purple)
            .frame(height: 120)
            .overlay(
                ZStack{
                    HStack{
                        Spacer()
                        VStack{
                            Image(systemName: cardViewModel.studyCard.passed ? "star.fill" : "star")
                        }
                    }
                    Text(flipped ? cardViewModel.studyCard.answer : cardViewModel.studyCard.question)
                        .foregroundColor(flipped ? .black : .white)
                        .font(.custom("Avenir", size: 24))
                }
                .padding()
            )
            .onTapGesture {
                withAnimation{
                    flipped.toggle()                    
                }
            }
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(cardViewModel: CardViewModel(studyCard: StudyCard(question: "question", answer: "answer")))
    }
}
