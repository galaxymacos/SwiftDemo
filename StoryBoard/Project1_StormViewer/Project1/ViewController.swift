//
//  ViewController.swift
//  Project1
//
//  Created by Xun Ruan on 2021/8/4.
//

import UIKit

// One screen of information
class ViewController: UITableViewController {
    var pictures:[String] = []
    var picturesVisitTime: [String: Int] = [:]
    // After the view has been loadeds
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true   // Only on the main screen usually
//        DispatchQueue.global(qos: .userInitiated).async {[weak self] in
//            self?.fetchImage()
//        }
        performSelector(inBackground: #selector(fetchImage), with: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let data = UserDefaults.standard.object(forKey: "data") as? Data{
            
            if let DecodedData = try? JSONDecoder().decode([String: Int].self, from: data){
                picturesVisitTime = DecodedData
            }
        }
    }
    
    @objc func fetchImage(){
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items{
            if item.hasPrefix("nssl"){
                pictures.append(item)
            }
        }
            pictures.sort()
        for picture in pictures {
            picturesVisitTime[picture] = 0
        }
        DispatchQueue.main.async {[weak self] in
            self?.tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
            
        }
    }
    
    @objc func shareTapped(){
        let vc = UIActivityViewController(activityItems: ["StoreViewer"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
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
//        cell.textLabel?.text = pictures[indexPath.row]  // add a text in the cell
        cell.textLabel?.text = "Picture \(indexPath.row+1) in \(pictures.count)"
        cell.detailTextLabel?.text = "Has been viewed for \(picturesVisitTime[pictures[indexPath.row]] ?? -1)"
        return cell
    }

    // this event will be fired when a row is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // we tell storyboard to instantiate a view controller but it can't guess which controller it is based on its name
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{   // Instantiate a view (ref storyboard because every view is inside storyboard)
            vc.selectedImage = pictures[indexPath.row]
            picturesVisitTime[pictures[indexPath.row]]! += 1
            // Navigation controllers manage a stack of view controllers that can be pushed by us.
            // This view controller stack is what gives us smooth sliding in and out
            navigationController?.pushViewController(vc, animated: true)
            save()
        }
    }
    
    func save(){
        if let data = try? JSONEncoder().encode(picturesVisitTime){
            UserDefaults.standard.set(data, forKey: "data")
        }
    }
}

