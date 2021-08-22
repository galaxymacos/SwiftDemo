//
//  ViewController.swift
//  CollectionView
//
//  Created by Xun Ruan on 2021/8/20.
//

import UIKit

class ViewController: UIViewController {

    enum Section{
        case main
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Section and Int must conform to hashable
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: set the collection view's layout to be our configured layout
        collectionView.collectionViewLayout = configureLayout()
        configureDataSource()
    }

    func configureLayout()->UICollectionViewCompositionalLayout{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func configureDataSource(){
        // MARK: - Tell the system what data it contains and how to populate the data
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: self.collectionView){ (collectionView, indexPath, number) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCell.reuseIdentifier, for: indexPath) as? NumberCell else { fatalError("Cannot create new cell") }
            cell.label.text = number.description
            
            return cell
        }
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        initialSnapshot.appendSections([.main])
        // If you only have a section
        initialSnapshot.appendItems(Array(100...200))
        // else
//        initialSnapshot.appendItems(Array(100...200), toSection: .main)
        
        // MARK: Should appear instantly as it is the first launch
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
}

