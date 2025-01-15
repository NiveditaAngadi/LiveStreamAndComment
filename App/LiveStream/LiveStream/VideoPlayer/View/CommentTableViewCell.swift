//
//  CommentTableViewCell.swift
//  LiveStream
//
//  Created by Nivedita Angadi on 08/01/25.
//

import UIKit
import Cartography

class CommentTableViewCell: UITableViewCell {
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let commentLabel = UILabel()
    
    var comment: Comment? {
        didSet {
            guard let comment else { return }
            bind(comment)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func bind(_ comment: Comment) {
        if let picUrl = comment.picUrl {
            profileImageView.loadImage(from: picUrl)
        }
        
        nameLabel.text = comment.userName
        commentLabel.text = comment.comment
    }
    
    private func setup() {
        backgroundColor = .clear
        selectionStyle = .none
        
        let holderStackView = UIStackView()
        holderStackView.axis = .horizontal
        holderStackView.spacing = 8.0
        
        contentView.addSubview(holderStackView)
        constrain(holderStackView, contentView) { holderStackView, contentView in
            holderStackView.leading == contentView.leading
            holderStackView.trailing == contentView.trailing
        }
    
        holderStackView.addArrangedSubview(profileImageView)
        profileImageView.contentMode = .scaleAspectFit
        constrain(profileImageView) { imageView in
            imageView.width == 27.0
            imageView.height == 27.0
        }
        profileImageView.layer.cornerRadius = 13.5
        profileImageView.layer.masksToBounds = true
        
        let labelStackView = UIStackView()
        labelStackView.axis = .vertical
        
        labelStackView.addArrangedSubview(nameLabel)
        nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7)
        nameLabel.font = .systemFont(ofSize: 9.0)
        
        commentLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        commentLabel.numberOfLines = 0
        commentLabel.font = .systemFont(ofSize: 9.0)
        commentLabel.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        
        let commentHolderView = UIView()
        commentHolderView.addSubview(commentLabel)
        constrain(commentLabel, commentHolderView) { commentLabel, holderView in
            commentLabel.edges == holderView.edges
        }
        
        labelStackView.addArrangedSubview(commentHolderView)
        holderStackView.addArrangedSubview(labelStackView)
    }
}
