//
//  EditCards.swift
//  AnkiCopy
//
//  Created by Xun Ruan on 2021/7/22.
//

import SwiftUI

struct EditCards: View {
    @State var cards = [Card]()
    @State var prompt = ""
    @State var answer = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View{
        NavigationView{
            
                List{
                    Section(header: Text("ADD NEW CARD")){
                        TextField("Prompt", text: $prompt)
                        TextField("Answer", text: $answer)
                        Button("Add card")
                            {
                                let trimmedPrompt = prompt.trimmingCharacters(in: .whitespaces)
                                let trimmedAnswer = answer.trimmingCharacters(in: .whitespaces)
                                if(trimmedPrompt.isEmpty || trimmedAnswer.isEmpty){
                                    return
                                }
                                let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
                                cards.insert(card, at: 0)
                                saveData()
                            }
                    }
                    
                    Section{
                        ForEach(0..<cards.count, id: \.self){ index in
                                VStack{
                                
                                    Text(cards[index].prompt)
                                        .font(.headline)
                                    Text(cards[index].answer)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .onDelete(perform: { indexSet in
                                cards.remove(atOffsets: indexSet)
                                saveData()
                            })
                    }
                }
                .navigationBarTitle(Text("Edit Cards"))
                .navigationBarItems(trailing: Button("Done"){presentationMode.wrappedValue.dismiss()})
                .listStyle(GroupedListStyle())
                .onAppear(perform: loadData)
            
        }
        // Stop showing the non-existent detail view
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func saveData(){
        if let data = try? JSONEncoder().encode(cards){
            UserDefaults.standard.set(data, forKey: "data")
        }
    }
    
    func loadData(){
        if let data = UserDefaults.standard.data(forKey: "data"){
            if let decoded = try? JSONDecoder().decode([Card].self, from: data){
                cards = decoded
            }
        }
    }
}


struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards()
    }
}
