//
//  AppsSearchController.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 19/06/24.
//

import UIKit
class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let iTunesServiceInstance:ITunesServiceProtocol = iTunesService()
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
        return 5
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchResultCollectionViewCell
        cell.nameLabel.text = "HERE IS MY APP NAME"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    fileprivate func fetchITunes() {
        iTunesServiceInstance.fetchITunes { result in
            switch result {
            case .success(let apps):
                for app in apps {
                    print("App Name: \(app.primaryGenreName), Description: \(app.trackName)")
                }
            case .failure(let error):
                print("Failed to fetch apps:", error)
            }
        }
        
    }
}
