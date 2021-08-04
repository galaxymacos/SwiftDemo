//
//  ViewController.swift
//  GenericAPICaller
//
//  Created by Xun Ruan on 2021/8/3.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    struct Constants{
        static let usersUrl = URL(string: "https://jsonplaceholder.typicode.com/users")
        static let todolistUrl = URL(string: "https://jsonplaceholder.typicode.com/todos")
    }
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
}

extension URLSession{
    enum CustomError: Error{
        case invalidUrl
        case invalidData
    }
    
    //
    func request<T: Codable>(from url: URL?,    // the url that contains the JSON file
                             expectingType: T.Type, // the type that
                             completion: @escaping (Result<T, Error>)->Void){
        // 1. Unwrap our url
        guard let url = url else{
            completion(.failure(CustomError.invalidUrl))
            return
        }
        let task = dataTask(with: url){data, _, error in
            guard let data = data else{
                if let error = error {
                    completion(.failure(error))
                }
                else{
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            do{
                let result = try JSONDecoder().decode(expectingType, from: data)
                completion(.success(result))
            }catch{
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
}
