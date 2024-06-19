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
        
        let postSteve = Post(name: "Steve Jobs", statusText: "The buttonStackView is constrained to be at the bottom of the cell, ensuring it stretches horizontally and has a height of 44 points. The buttonStackView is constrained to be at the bottom of the cell, ensuring it stretches horizontally and has a height of 44 points.")
        
        
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
        
        let nameLabelHeight: CGFloat = 44 // Fixed height
        let profileImageHeight: CGFloat = 44 // Fixed height
        
        let statusTextHeight = post.statusText.height(withConstrainedWidth: view.frame.width - 16, font: UIFont.systemFont(ofSize: 14))
        
        
        let statusImageHeight: CGFloat = 200 // Fixed height
        let likesCommentsLabelHeight: CGFloat = 24 // Fixed height
        let dividerLineHeight: CGFloat = 3 // Fixed height
        let buttonStackViewHeight: CGFloat = 44 // Fixed height
        
        let totalHeight = nameLabelHeight + profileImageHeight + statusTextHeight + statusImageHeight + likesCommentsLabelHeight + dividerLineHeight + buttonStackViewHeight + 64 // 64 for padding and spacing
        
        return CGSize(width: view.frame.width, height: totalHeight)
    }
}

class FeedCell: UICollectionViewCell {
    var post: Post? {
        didSet {
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
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
    
    let profileImageView: UIImageView = {
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
    
    let likeButton = FeedCell.buttonForTitle(title: "Like", imageName: "like")
    let commentButton = FeedCell.buttonForTitle(title: "Comment", imageName: "comment")
    let shareButton = FeedCell.buttonForTitle(title: "Share", imageName: "share")
    
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
    
    func setupViews() {
        backgroundColor = .white
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabel)
        addSubview(dividerLineView)
        buttonStackView.addArrangedSubview(likeButton)
        buttonStackView.addArrangedSubview(commentButton)
        buttonStackView.addArrangedSubview(shareButton)
        addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            profileImageView.widthAnchor.constraint(equalToConstant: 44),
            profileImageView.heightAnchor.constraint(equalToConstant: 44),
            
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            
            statusTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            statusTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            statusTextView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 4),
            
            statusImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            statusImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            statusImageView.topAnchor.constraint(equalTo: statusTextView.bottomAnchor, constant: 4),
            statusImageView.heightAnchor.constraint(equalToConstant: 200),
            
            likesCommentsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            likesCommentsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            likesCommentsLabel.topAnchor.constraint(equalTo: statusImageView.bottomAnchor, constant: 8),
            
            dividerLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            dividerLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            dividerLineView.topAnchor.constraint(equalTo: likesCommentsLabel.bottomAnchor, constant: 8),
            dividerLineView.heightAnchor.constraint(equalToConstant: 1),
            
            buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
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
