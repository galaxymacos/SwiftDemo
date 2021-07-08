//
//  ContentView.swift
//  Moonshot
//
//  Created by Xun Ruan on 2021-07-08.
//

import SwiftUI

/*  Resizing image to fit the screen using GrometryReader
struct ContentView: View {
    var body: some View {
        
        /* Not resizing image
         Image("Example")
         .frame(width: 300, height: 300)
         .clipped()
         
         */
        
        /*  Resize image combining .resizable() and .aspectRatio(contentMode: )
         Image("Example")
         .resizable()
         .aspectRatio(contentMode: .fit)
         //            .aspectRatio(contentMode: .fill)
         .frame(width: 300, height: 300)
         
         */
        
        /* GeometryReader
         GeometryReader{ geo in
         Image("Example")
         .resizable()
         .aspectRatio(contentMode: .fit)
         .frame(width: geo.size.width)
         */
        
        }
        

    }
}
 */

struct ContentView: View {
    
    struct CustomText: View {
        @State var text: String
        
        var body: some View{
            Text("\(text)")
        }
        
        init(text: String) {
            print("Creating a new custom text")
            self.text = text
        }
    }
    
    var body: some View{
        // ScrollView creates all views at one time
        ScrollView(.vertical){
            VStack(spacing: 10){
                ForEach(1..<100){
                    CustomText(text: "Item \($0)")
                        .font(.title)
                }
            }
            /* List creates View only when necessary
             List{
             ForEach(1..<100){
             CustomText(text: "Item \($0)")
             .font(.title)
             }
             */
            
            // Make the whole area scrollable
            .frame(maxWidth: .infinity)
        }
    
        //
        
        
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
