//
//  ViewController.swift
//  FacebookFeed
//
//  Created by Animesh on 25/05/24.
//

import UIKit
let cellID = "cellID"
class Post {
    var name: String
    var statusText: String
    
    init(name: String, statusText: String) {
        self.name = name
        self.statusText = statusText
    }
}

class ViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let postMark = Post(name: "Mark Zuckerberg", statusText: "Meanwhile the beast turned the other way down")
        
        let postSteve = Post(name: "Steve Jobs", statusText: "The buttonStackView is constrained to be at the bottom of the cell, ensuring it stretches horizontally and has a height of 44 points.")

        
        posts.append(postMark)
        posts.append(postSteve)
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        navigationItem.title = "Facebook Feed"
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellID)
        // Do any additional setup after loading the view.
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! FeedCell
        feedCell.post = posts[indexPath.row]
        return feedCell
    }
    // UICollectionViewDelegateFlowLayout method
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let post = posts[indexPath.item]
           
           // Calculate the height for status text
           let statusTextHeight = post.statusText.height(withConstrainedWidth: view.bounds.width - 16, font: UIFont.systemFont(ofSize: 14))
           
           // Base height calculation
           let baseHeight: CGFloat = 8 + 44 + 8 + statusTextHeight + 8 + 200 + 8 + 24 + 8 + 3 + 8 + 44 + 8
           
           return CGSize(width: view.bounds.width, height: baseHeight)
       }
}

class FeedCell: UICollectionViewCell {
    var post: Post? {
        didSet{
            if let name = post?.name {
                let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
                attributedText.append(NSMutableAttributedString(string: "\nDecember 18 * San Francisco *", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1)]))
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
                
                nameLabel.attributedText = attributedText
            }
            statusTextView.text = post?.statusText
           
            
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
       
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Meanwhile the beast turned to the other side"
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.backgroundColor = UIColor.green
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lebron-james")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lebron-james")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
        label.text = "488 Likes   10.7K Comments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let likeButton: UIButton = buttonForTitle(title: "Like", imageName: "Like")
    let commentButton = buttonForTitle(title: "Comment", imageName: "Comment")
    let shareButton = buttonForTitle(title: "share", imageName: "share")
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    static func buttonForTitle(title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 163), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews() {
        backgroundColor = UIColor.white
        addSubview(nameLabel)
        addSubview(profileImage)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabel)
        addSubview(dividerLineView)
        addSubview(likeButton)
        buttonStackView.addArrangedSubview(likeButton)
        buttonStackView.addArrangedSubview(commentButton)
        buttonStackView.addArrangedSubview(shareButton)
        addSubview(buttonStackView)
        
        // Add constraint for profile image view
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            profileImage.widthAnchor.constraint(equalToConstant: 44),
            profileImage.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // Add constraint for name label
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8)
        ])
        
        // Add constraint for status text view
        NSLayoutConstraint.activate([
            statusTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            statusTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            statusTextView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 4),
            //            statusTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
            statusImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            statusImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            statusImageView.topAnchor.constraint(equalTo: statusTextView.bottomAnchor, constant: 4),
            statusImageView.heightAnchor.constraint(equalToConstant: 200)

        ])
        NSLayoutConstraint.activate([
            likesCommentsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            likesCommentsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            likesCommentsLabel.topAnchor.constraint(equalTo: statusImageView.bottomAnchor, constant: 8),
            likesCommentsLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        NSLayoutConstraint.activate([
            dividerLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            dividerLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            dividerLineView.heightAnchor.constraint(equalToConstant: 3),
            dividerLineView.topAnchor.constraint(equalTo: likesCommentsLabel.bottomAnchor, constant: 8)
        ])

        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            buttonStackView.topAnchor.constraint(equalTo: dividerLineView.bottomAnchor, constant: 8),
            buttonStackView.heightAnchor.constraint(equalToConstant: 44),
            buttonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
    }
}
extension UIColor{
    static func rgb(red:CGFloat, green:CGFloat, blue:CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}
