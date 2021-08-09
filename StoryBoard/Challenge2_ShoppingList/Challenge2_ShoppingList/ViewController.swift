//
//  ViewController.swift
//  Challenge2_ShoppingList
//
//  Created by Xun Ruan on 2021/8/9.
//

import UIKit

class ViewController: UITableViewController {

    var items: [String]? = ["car", "house"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addShoppingCartItem))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareItems))
        if items == nil{
            items = []
        }
    }

    @objc func addShoppingCartItem(){
        let ac = UIAlertController(title: "Item", message: "?", preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        ac.addAction(UIAlertAction(title: "Add", style: .default){[weak self, weak ac] fe in
            guard let itemToAdd = ac?.textFields?[0].text else {return}
            self?.items?.insert(itemToAdd, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        })
        present(ac, animated: true)
         
    }
    
    @objc func shareItems(){
        let itemsInString = items?.joined(separator: "\n")
        let avc = UIActivityViewController(activityItems: [itemsInString!], applicationActivities: [])
        avc.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(avc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = items?[indexPath.row]
        return cell
    }
    
    
}

