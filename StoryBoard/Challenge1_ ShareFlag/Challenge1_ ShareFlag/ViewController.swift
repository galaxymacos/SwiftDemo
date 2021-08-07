//
//  ViewController.swift
//  Challenge1_ ShareFlag
//
//  Created by Xun Ruan on 2021/8/7.
//

import UIKit

class ViewController: UITableViewController {

    var countries = ["estonia", "france", "germany", "ireland", "italy", "manaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Image", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Instantiate the detail view of this image
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            detailViewController.image = countries[indexPath.row]
            navigationController?.pushViewController(detailViewController, animated: true)
        }
        
    }
}

