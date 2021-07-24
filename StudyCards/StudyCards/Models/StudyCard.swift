//
//  StudyCard.swift
//  StudyCards
//
//  Created by Xun Ruan on 2021/7/23.
//

import FirebaseFirestoreSwift

struct StudyCard: Identifiable, Codable {
    // To connect to firestore
    @DocumentID var id: String?
    var question: String
    var answer: String
    var passed: Bool = false
}
