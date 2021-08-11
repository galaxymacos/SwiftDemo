//
//  ViewController.swift
//  Project7_WhiteHousePetition
//
//  Created by Xun Ruan on 2021/8/9.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var originalPetitions = [Petition]()
    var isFilterOn:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        performSelector(inBackground: #selector(fetchJson), with: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showCredit))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(filterPetition))
    }
    
    // Run in background
    @objc func fetchJson(){
        let urlString: String
        if navigationController?.tabBarItem.tag == 0{
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }
        else{
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        originalPetitions = petitions
        
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    parse(json: data)
                }
                else{
                    performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
                }
            }
            else{
                performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
            }
        
        
    }
    
    // Run in background
    private func parse(json: Data){
        if let decoded = try? JSONDecoder().decode(Petitions.self, from: json){
            petitions = decoded.results
            // Update UI should be on the main thread
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        }
        else{
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = petitions[indexPath.row].title
        cell.detailTextLabel?.text = petitions[indexPath.row].body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailvc = DetailViewController()
        detailvc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(detailvc, animated: true)
    }
    
    @objc func showError(){
        let ac = UIAlertController(title: "Error", message: "Please check your connection", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    @objc func showCredit(){
        let ac = UIAlertController(title: "Credits", message: "We the people API of the whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    @objc func filterPetition(){
        if !self.isFilterOn{
            let ac = UIAlertController(title: "Filter", message: "Add string to filter", preferredStyle: .alert)
            ac.addTextField(configurationHandler: nil)
            ac.addAction(UIAlertAction(title: "Submit", style: .default){[weak self, weak ac] _ in
                self?.originalPetitions = self!.petitions
                    let filterString = ac?.textFields?[0].text ?? ""
                    print(filterString)
                    self?.petitions = self?.petitions.filter{$0.title.contains(filterString)} ?? [Petition]()
                    self?.tableView.reloadData()
                    self?.isFilterOn.toggle()
                    
                
            })
            
            present(ac, animated: true)
        }
        else{
            self.petitions = self.originalPetitions
            self.tableView.reloadData()
            self.isFilterOn.toggle()
        }
    }
}

