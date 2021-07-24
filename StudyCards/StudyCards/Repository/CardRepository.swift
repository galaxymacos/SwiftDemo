//
//  CardRepository.swift
//  StudyCards
//
//  Created by Xun Ruan on 2021/7/23.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class CardRepository: ObservableObject{
    private let path = "studyCards"
    
    // A fire store is like a database
    private let store = Firestore.firestore()
    @Published var studyCards: [StudyCard] = []
    
    init() {
        get()
    }
    
    func get(){
        // accessing a specific database through store.collection(path)
        store.collection(path).addSnapshotListener{ (snapshot, error) in
            if let error = error{
                print(error)
                return
            }
            self.studyCards = snapshot?.documents.compactMap{
                try? $0.data(as: StudyCard.self)
            } ?? []
        }
    }
    
    func add(_ studyCard: StudyCard){
        do{
            _ = try store.collection(path).addDocument(from: studyCard)
        }
        catch{
            fatalError("Adding a study card failed")
        }
    }
    
    func delete(_ studyCard: StudyCard){
        guard let documentId = studyCard.id else {return}

        store.collection(path).document(documentId).delete{ error in
            if let error = error{
                print("Unable to remove the card: \(error.localizedDescription)")
            }
        }
        
    }
    
    func update(_ studyCard: StudyCard){
        guard let documentId = studyCard.id else {return}
        
        do{
            try store.collection(path).document(documentId).setData(from: studyCard)
        }
        catch{
            print("Unable to update the card: \(error.localizedDescription)")
        }
    }
}
