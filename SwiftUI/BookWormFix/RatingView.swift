//
//  RatingView.swift
//  BookWormFix
//
//  Created by Xun Ruan on 2021/7/13.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    var label = ""
    var maximumRating = 5
    
    var offImage:Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack{
            if !label.isEmpty {
                Text(label)
            }
            ForEach(1..<maximumRating+1){num in
                image(for: num)
                    .foregroundColor(num > rating ? offColor : onColor)
                    .onTapGesture {
                        self.rating = num
                    }
            }
        }
    }
    
    func image(for starValue: Int)->Image{
        if(starValue > rating){
            return offImage ?? onImage
        }
        else{
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(3))
    }
}
