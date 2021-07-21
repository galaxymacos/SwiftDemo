//
//  CardView.swift
//  AnkiCopy
//
//  Created by Xun Ruan on 2021/7/21.
//

import SwiftUI

struct CardView: View {
    @State var card: Card
    @State var isShowingAnswer = false
    @State var offset = CGSize.zero
    var removal: (()->Void)? = nil
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .shadow(radius: 10)
            
            VStack{
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(self.offset.width / 5)))
        .offset(x:self.offset.width * 5, y:0)
        .opacity(2-Double(abs(offset.width/50)))
        .gesture(DragGesture()
                    .onChanged{ gesture in
                        offset = gesture.translation
                    }
                    .onEnded{ gesture in
                        if abs(offset.width) >= 100{
                            removal?()
                        }
                        else{
                            offset = .zero
                        }
                    })
        .onTapGesture {
            isShowingAnswer.toggle()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
