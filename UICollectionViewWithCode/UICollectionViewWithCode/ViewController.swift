//
//  ViewController.swift
//  UICollectionViewWithCode
//
//  Created by Animesh on 08/06/24.
//

import UIKit
/*
 
 class CustomCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
 let customCellIdentifier = "customCellIdentifier"
 let names = ["Name1", "Name2", "Name3"]
 
 override func viewDidLoad() {
 super.viewDidLoad()
 collectionView.register(CustomCell.self, forCellWithReuseIdentifier: customCellIdentifier)
 // Do any additional setup after loading the view.
 }
 override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 return 3
 }
 override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath) as! CustomCell
 customCell.label.text = names[indexPath.item]
 return customCell
 }
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 return CGSize(width: view.frame.width, height: 200)
 }
 
 
 }
 class CustomCell: UICollectionViewCell {
 override init(frame: CGRect) {
 super.init(frame: frame)
 setupView()
 }
 let label:UILabel = {
 let label = UILabel()
 label.translatesAutoresizingMaskIntoConstraints = false
 return label
 }()
 func setupView() {
 backgroundColor = UIColor.red
 
 addSubview(label)
 NSLayoutConstraint.activate([
 label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
 label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
 ])
 }
 
 required init?(coder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }
 }
 */
class CustomCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath) as! CustomCell
        collectionViewCell.label.text = 
    }
    
    let names = ["Name1", "Name2", "Name3"]
    let customCellIdentifier = "customCellIdentifier"
    var collectionView: UICollectionView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        let flowLayout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: customCellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
    }
}
class CustomCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    let label:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    func setupView() {
        backgroundColor = UIColor.red
        
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
