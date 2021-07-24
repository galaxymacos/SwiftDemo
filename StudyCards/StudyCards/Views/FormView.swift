//
//  FormView.swift
//  StudyCards
//
//  Created by Xun Ruan on 2021/7/24.
//

import SwiftUI

struct FormView: View {
    @State private var question = ""
    @State private var answer = ""
    
    var didAddCard: (_ studyCard: StudyCard) -> Void
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    TextField("Question", text: $question)
                    TextField("Answer", text: $answer)
                }
                Button("Create card"){
                    let card = StudyCard(question: question, answer: answer)
                    didAddCard(card)
                }.disabled(question.isEmpty || answer.isEmpty).padding()
            }
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView { StudyCard in
            
        }
    }
}
