//
//  CardView.swift
//  AnkiCopy
//
//  Created by Xun Ruan on 2021/7/21.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    // For blind people
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    @State var card: Card
    @State var isShowingAnswer = false
    @State var offset = CGSize.zero
    
    @State var haptic = UINotificationFeedbackGenerator()
   
    var removal: (()->Void)? = nil
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(differentiateWithoutColor
                            ? Color.white.opacity(1 - Double(abs(offset.width / 50)))
                            : Color.white
                    )
                    .shadow(radius: 10)
                    .background(differentiateWithoutColor
                                    ? nil
                                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                                    .fill(offset.width>0 ? Color.green : Color.red))
                
                VStack{
                    if accessibilityEnabled{
                        Text(isShowingAnswer ? card.answer : card.prompt)
                            .font(.largeTitle)
                            .foregroundColor(.black)
                    }
                    else{
                        Text(card.prompt)
                            .font(.largeTitle)
                            .foregroundColor(.black)
                        if isShowingAnswer {
                            Text(card.answer)
                                .font(.title)
                                .foregroundColor(.gray)
                        }
                    }
                    
                }
                .padding(20)
                .multilineTextAlignment(.center)
                
            }
            
            
        }
        
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(self.offset.width / 5)))
        .offset(x:self.offset.width * 5, y:0)
        .opacity(2-Double(abs(offset.width/50)))
        .accessibility(addTraits: .isButton)
        .gesture(DragGesture()
                    .onChanged{ gesture in
                        offset = gesture.translation
                        haptic.prepare()
                    }
                    .onEnded{ gesture in
                        if abs(offset.width) >= 100{
                            if(offset.width>0){
                                haptic.notificationOccurred(.success)
                            }
                            else{
                                haptic.notificationOccurred(.error)
                            }
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
