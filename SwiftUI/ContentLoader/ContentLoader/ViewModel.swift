//
//  ViewModel.swift
//  ViewModel
//
//  Created by Xun Ruan on 2021/8/3.
//

import SwiftUI

// Hashable makes the class iterable in foreach, Codable is required for container of JSON file
struct Course: Hashable, Codable{
    var name: String
    var image: String
}

class ViewModel: ObservableObject{
    @Published var courses: [Course] = []
    
    /**
     It fetches the name and url of the image of the course 
     */
    func fetch(){
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else{return}
        let task = URLSession.shared.dataTask(with: url){ [weak self]data, _, error in
            // SwiftUI uses ',' to replace 'and'
            guard let data = data, error == nil else{
                return
            }
            do{
                let courses = try JSONDecoder().decode([Course].self, from: data)
                DispatchQueue.main.async {
                    self?.courses = courses
                }
                
            }
            catch{
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
}

class ViewModelUrlImage: ObservableObject{
    @Published var data: Data?  // We want the view (In this case, the image) to update when we have data, that's why we mark it as @State
    func fetchImageFromUrl(urlString: String){
        guard let url = URL(string: urlString) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){data, _, _ in
            self.data = data    //Function can't assign to the variable in struct that doesn't mark as @State
        }
        task.resume()
    }
}
