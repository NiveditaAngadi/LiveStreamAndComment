//
//  CommentsHolderView.swift
//  LiveStream
//
//  Created by Nivedita Angadi on 07/01/25.
//

import Foundation
import UIKit
import Cartography

// View - holds the comments table view
class CommentsHolderView: UIView, UITableViewDataSource, UITextFieldDelegate {
    let commentsTableView = UITableView()
    let commentTextField = UITextField()
    let bottomContentView = UIStackView()
    let contentHolderView = UIStackView()

    var currentComments = [Comment]()

    var comments = [Comment](){
        didSet {
            loadDataBasedOnTimer()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupKeyboardNotification()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - UITableViewDataSource -
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
        cell.comment = currentComments[indexPath.row]
        return cell
    }
    // MARK: - UITextField delegate Methods -
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        commentTextField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       // Create a comment object
        let id = Int.random(in: 60..<299)
        let name = "TestUser"
        let picUrl = "https://fastly.picsum.photos/id/477/200/200.jpg?hmac=pGA68LBET23UPGB7L8xL1pA7PYT_x7JazGX__CnlliU"
        let comment = textField.text ?? ""
        
        let commentObj = Comment(commentId: id, userName: name, picUrl: picUrl, comment: comment)
        currentComments.append(commentObj)
        commentsTableView.reloadData()
    }
    
    // MARK: - Private Methods -
   
    private func setupUI() {
        commentsTableView.dataSource = self
        
        commentsTableView.backgroundColor = .clear
        
        commentsTableView.rowHeight = UITableView.automaticDimension
        commentsTableView.estimatedRowHeight = 320
        
        commentsTableView.separatorStyle = .none
        commentsTableView.allowsSelection = false
        
        commentsTableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentCell")
                
        contentHolderView.spacing = 10.0
        contentHolderView.axis = .vertical

        addSubview(contentHolderView)
        constrain(contentHolderView, self) { holderView, contentView in
            holderView.leading == contentView.leading + 13
            holderView.top == contentView.top + 8
            holderView.trailing == contentView.trailing - 13
            holderView.bottom == contentView.bottom - 54
        }
        contentHolderView.addArrangedSubview(commentsTableView)
        
        // Bottom content view
        let bottomContentView = UIStackView()
        bottomContentView.axis = .horizontal
        contentHolderView.addArrangedSubview(bottomContentView)
        
        // Comment Input View
        let commentInputView = UIView()
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "textFieldBackground")
        
        commentInputView.addSubview(backgroundImageView)
        constrain(backgroundImageView, commentInputView) { background, inputView in
            background.edges == inputView.edges
        }
        commentTextField.textAlignment = .left
        commentTextField.delegate = self
        commentTextField.font = UIFont.systemFont(ofSize: 12)
        commentTextField.textColor = UIColor.white
        commentTextField.attributedPlaceholder = NSAttributedString(string: "Comment", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        commentInputView.addSubview(commentTextField)
        
        let emojiImageView = UIImageView()
        emojiImageView.image = UIImage(named: "mdi_emoji-outline")
        emojiImageView.contentMode = .scaleAspectFit
        commentInputView.addSubview(emojiImageView)
        constrain(emojiImageView, commentInputView) { emoji, holderView in
            emoji.width == 18
            emoji.height == 18
            emoji.trailing == holderView.trailing - 8
            emoji.centerY == holderView.centerY
        }

        constrain(commentTextField, commentInputView) { textField, inputView in
            textField.leading == inputView.leading + 8
            textField.trailing == inputView.trailing
            textField.bottom == inputView.bottom
            textField.top == inputView.top
        }
        
        bottomContentView.addArrangedSubview(commentInputView)
        
        // Spacer
        bottomContentView.addArrangedSubview(UIView())
        
        // Rose
        let roseHolderView = UIStackView()
        roseHolderView.axis = .vertical
        roseHolderView.alignment = .center
        
        let roseImageView = UIImageView()
        roseImageView.image = UIImage(named: "noto_rose")
        roseImageView.contentMode = .scaleAspectFit
    
        roseHolderView.addArrangedSubview(roseImageView)
        constrain(roseImageView) { rose in
            rose.width == 24
            rose.height == 24
        }
        
        let roseTextLabel = UILabel()
        roseTextLabel.text = "Rose"
        roseTextLabel.textColor = .white
        roseTextLabel.font = UIFont.systemFont(ofSize: 10)
        roseHolderView.addArrangedSubview(roseTextLabel)
        
        bottomContentView.addArrangedSubview(roseHolderView)

        // Gift
        let giftHolderView = UIStackView()
        giftHolderView.axis = .vertical
        giftHolderView.alignment = .center
        
        let giftImageView = UIImageView()
        giftImageView.image = UIImage(named: "noto_wrapped-gift")
        giftImageView.contentMode = .scaleAspectFit
        
        giftHolderView.addArrangedSubview(giftImageView)
        constrain(giftImageView) { gift in
            gift.width == 24
            gift.height == 24
        }
        
        let giftTextLabel = UILabel()
        giftTextLabel.text = "Gift"
        giftTextLabel.textColor = .white
        giftTextLabel.font = UIFont.systemFont(ofSize: 10)
        giftHolderView.addArrangedSubview(giftTextLabel)
        
        bottomContentView.addArrangedSubview(giftHolderView)
        
        // Share
        let shareHolderView = UIStackView()
        shareHolderView.axis = .vertical
        shareHolderView.alignment = .center
        
        let shareImageView = UIImageView()
        shareImageView.image = UIImage(named: "icon_share")
        shareImageView.contentMode = .scaleAspectFit
        
        shareHolderView.addArrangedSubview(shareImageView)
        constrain(shareImageView) { share in
            share.width == 24
            share.height == 24
        }
        
        let shareLabel = UILabel()
        shareLabel.text = "2"
        shareLabel.textColor = .white
        shareLabel.font = UIFont.systemFont(ofSize: 10)
        shareHolderView.addArrangedSubview(shareLabel)
        
        bottomContentView.addArrangedSubview(shareHolderView)
    }
    
  // Keyboard show and hide notifications, related methods
    private func setupKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShowInView(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHideInView(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    @objc private func keyboardDidShowInView(_ notification: Notification) {
        let keyboardEndFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        contentHolderView.frame.origin.y -= keyboardEndFrame?.cgRectValue.size.height ?? 0
    }
    
    @objc private func keyboardDidHideInView(_ notification: Notification) {
        contentHolderView.frame.origin.y = 0
    }
        
    private func loadDataBasedOnTimer() {
      Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            if let self {
                while comments.count > 0 {
                    if let comment = self.comments.first {
                        print(comment.commentId)
                        currentComments.append(comment)
                        self.comments.removeFirst()
                    }
                    self.commentsTableView.beginUpdates()
                    let range = NSMakeRange(0, commentsTableView.numberOfSections)
                    let sections = NSIndexSet(indexesIn: range)
                    self.commentsTableView.reloadSections(sections as IndexSet, with: .top)
                    self.commentsTableView.endUpdates()
                }
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
