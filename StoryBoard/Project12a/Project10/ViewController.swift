//
//  ViewController.swift
//  Project10
//
//  Created by Xun Ruan on 2021/8/11.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        
        if let savedPeople = UserDefaults.standard.object(forKey: "people") as? Data{
            if let decodedPoeple = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople) as? [Person]{
                people = decodedPoeple
            }
        }
    }
    
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else{
            fatalError("Unable to dequeue PersonCell.")
        }
        let person = people[indexPath.item]
        // the name is in our custom PersonCell type
        cell.name.text = person.name
        let urlPath = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(
            contentsOfFile: urlPath.path    // get path in string from url
        )
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        return cell
    }
    
    @objc func addNewPerson(){
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }
        picker.allowsEditing = true
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8){
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true, completion: nil)
    }
    
    private func getDocumentsDirectory()->URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
        let renameOrDeleteAlert = UIAlertController(title: "Rename or delete the person", message: "", preferredStyle: .alert)
        renameOrDeleteAlert.addAction(UIAlertAction(title: "Rename", style: .default){ [weak self] _ in
            let renameAlert = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
            renameAlert.addTextField()
            renameAlert.addAction(UIAlertAction(title: "Confirm", style: .default){[weak self, weak renameOrDeleteAlert] _ in
                guard let newName = renameOrDeleteAlert?.textFields?[0].text else { return }
                person.name = newName
                self?.collectionView.reloadData()
            })
            renameAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self?.present(renameAlert, animated: true)
        })
        renameOrDeleteAlert.addAction(UIAlertAction(title: "Delete", style: .default){ [weak self] _ in
            self?.people.remove(at: indexPath.item)
            collectionView.reloadData()
            self?.save()
        })
        present(renameOrDeleteAlert, animated: true)   
    }
    
    func save(){
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: people, requiringSecureCoding: false){
            UserDefaults.standard.set(savedData, forKey: "people")
        }
    }
}

