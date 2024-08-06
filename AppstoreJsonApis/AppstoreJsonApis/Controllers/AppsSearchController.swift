//
//  AppsSearchController.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 19/06/24.
//

import UIKit
import SDWebImage
class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let viewModel = AppsSearchViewModel()

    fileprivate var apps:[Apps] = []
    fileprivate let cellID = "id1234"
    override func viewDidLoad() {
           super.viewDidLoad()
           
           collectionView.backgroundColor = .white
           collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
           
           viewModel.onDataFetched = { [weak self] in
               DispatchQueue.main.async {
                   self?.collectionView.reloadData()
               }
           }
           
           viewModel.onError = { error in
               // Handle error (e.g., show an alert)
               print("Failed to fetch apps:", error)
           }
           
           viewModel.fetchApps(searchTerm: "instagram")
       }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchResultCollectionViewCell
        if let app = viewModel.app(at: indexPath.item) {
            cell.nameLabel.text = app.trackName
            cell.categoryLabel.text = app.primaryGenreName
            cell.ratingsLabel.text = "Ratings: \(app.averageUserRating ?? 0)"
            cell.appIconImageView.sd_setImage(with: URL(string: app.artworkUrl100))
            
            // Load images and other data as necessary
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
}
