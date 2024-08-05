//
//  AppsSearchController.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 19/06/24.
//

import UIKit
class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let iTunesServiceInstance:ITunesServiceProtocol = iTunesService()
    fileprivate var apps:[Apps] = []
    fileprivate let cellID = "id1234"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        fetchITunes()
    }
    
    init(){
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchResultCollectionViewCell
        let appResult = apps[indexPath.item]
        cell.nameLabel.text = appResult.trackName
        cell.categoryLabel.text = appResult.primaryGenreName
        cell.ratingsLabel.text = "Ratings: \(appResult.averageUserRating ?? 0)"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    fileprivate func fetchITunes() {
        iTunesServiceInstance.fetchITunes { result in
            switch result {
            case .success(let apps):
                self.apps = apps
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch apps:", error)
            }
        }
        
    }
}
