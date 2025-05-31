//
//  AppsController.swift
//  AppstoreJsonApis
//
//  Created by Akanksha on 11/08/24.
//

import UIKit

class AppsPageController: BaseListController, UICollectionViewDelegateFlowLayout {
    let dispatchGroup = DispatchGroup()
    let cellId = "id"
    let headerID = "headerID"
    private var viewModel: AppsPageViewModelProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        fetchInitialData()
    }
    func fetchInitialData() {
        fetchGames()
        fetchSocialApps()
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func fetchGames(){
        dispatchGroup.enter()
        viewModel?.fetchGames()
        viewModel?.onGamesFetched = { [weak self] in
            self?.dispatchGroup.leave()
        }
        viewModel?.onError = { [weak self] error  in
            self?.dispatchGroup.leave()
        }
    }
    
    func fetchSocialApps() {
        dispatchGroup.enter()
        viewModel?.fetchSocialApps()
        viewModel?.onSocialAppsFetched = { [weak self] in
            self?.dispatchGroup.leave()
        }
    }

    
    init(viewModel: AppsPageViewModelProtocol = AppsPageViewModel(service: ITunesGameService())){
        super.init()
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! AppsPageHeader
        header.configure(with: viewModel ?? AppsPageViewModel())
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.games.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
        cell.titleLabel.text = viewModel?.games[indexPath.item].feed.title
        cell.horizontalController.appGroup = viewModel?.games[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
