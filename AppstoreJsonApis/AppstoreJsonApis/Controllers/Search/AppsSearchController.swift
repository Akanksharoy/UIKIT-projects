//
//  AppsSearchController.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 19/06/24.
//

import UIKit
import SDWebImage
class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    private var viewModel: AppsSearchViewModelProtocol
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate var apps:[Apps] = []
    fileprivate let cellID = "id1234"
    fileprivate var searchDebounceTimer: Timer?
    
    
    init(viewModel: AppsSearchViewModelProtocol = AppsSearchViewModel(iTunesService: ITunesService())) {
        self.viewModel = viewModel
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupSearchBar()
        fetchItunesApp()
    }
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    func fetchItunesApp(searchText:String = "instagram") {
        viewModel.onDataFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        viewModel.onError = { error in
            // Handle error (e.g., show an alert)
            print("Failed to fetch apps:", error)
        }
        
        viewModel.fetchApps(searchTerm: searchText)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchResultCollectionViewCell
        if let app = viewModel.app(at: indexPath.item) {
            cell.app = app
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    fileprivate func setupSearchBar(){
        searchController.searchBar.placeholder = "Search for Apps.."
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.delegate = self
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        searchDebounceTimer?.invalidate()
        searchDebounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.fetchItunesApp(searchText: searchText)
        }
    }
}
