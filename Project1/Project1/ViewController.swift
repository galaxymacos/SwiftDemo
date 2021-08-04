//
//  ViewController.swift
//  Project1
//
//  Created by Xun Ruan on 2021/8/4.
//

import UIKit

// One screen of information
class ViewController: UITableViewController {
    var pictures: [String] = []
    // After the view has been loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true   // Only on the main screen usually
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        for item in items{
            if item.hasPrefix("nssl"){
                pictures.append(item)
            }
        }
        print(pictures)
    }
    
    // the parameter of the method decided what should happen
    // Seet the number of row in the table view
    override func tableView(_ tableView: UITableView    // This is the table view that triggers the effect
                            ,numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    
    // this method will be called for X times: X equals to the the number of rows
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get the current cell in the table view
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath) // iOS will reuse the cell that no longer appear on the screen
        cell.textLabel?.text = pictures[indexPath.row]  // add a text in the cell
        return cell
    }

    // this event will be fired when a row is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // we tell storyboard to instantiate a view controller but it can't guess which controller it is based on its name
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{   // Instantiate a view (ref storyboard because every view is inside storyboard)
            vc.selectedImage = pictures[indexPath.row]
            // we need to navigate to that view
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

