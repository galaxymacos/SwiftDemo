//
//  ViewController.swift
//  PhotoSearch
//
//  Created by Xun Ruan on 2021/9/23.
//

import UIKit

struct APIResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [Result]
}

struct Result: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let full: String
    let regular: String
}

class ViewController: UIViewController, UICollectionViewDelegate, UISearchBarDelegate {

   
    
    private var collectionView:UICollectionView?
    
    let searchBar = UISearchBar()
    
    var results: [Result] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: view.frame.size.width / 2, height: view.frame.size.width / 2)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.dataSource = self
        view.addSubview(collectionView)
        self.collectionView = collectionView
        
        searchBar.delegate = self
        view.addSubview(searchBar)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchBar.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: view.frame.size.width - 20, height: 50)
        collectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 55, width: view.frame.size.width, height: view.frame.size.height - 55)
    }
    
    func fetchPhoto(keyword: String) {
        let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=50&query=\(keyword)&client_id=ZihkiVo4y_I3Dkkb7JIbSJdMFdg5-sxW7bcHaPrYXXY"
        guard let url = URL(string: urlString) else { fatalError() }
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self.results = jsonResult.results
                    self.collectionView?.reloadData()
                }
            }
            catch {
                  
            }
            
            print("got data")
        }
        
        
        dataTask.resume()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            results = []
            collectionView?.reloadData()
            fetchPhoto(keyword: searchBar.text!)
        }
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageURLString = results[indexPath.row].urls.regular
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {
            fatalError("Can't find cell")
        }
        
        cell.configure(with: imageURLString)
        
        return cell
    }
    
}
