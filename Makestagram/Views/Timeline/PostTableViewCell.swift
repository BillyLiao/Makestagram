//
//  PostTableViewCell.swift
//  Makestagram
//
//  Created by 廖慶麟 on 2016/9/24.
//  Copyright © 2016年 Make School. All rights reserved.
//

import UIKit
import Bond
import Parse

class PostTableViewCell: UITableViewCell {
    
    var post: Post? {
        didSet {
            postDisposable?.dispose()
            likeDisposable?.dispose()
            
            if let post = post {
                // bind the image of the post to postImageView
                postDisposable = post.image.bindTo(postImageView.bnd_image)
                likeDisposable = post.likes.observe {(value: [PFUser]?) -> () in
                    if let value = value {
                        self.likesLabel.text = self.stringFromUserList(value)
                        self.likeButton.selected = value.contains(PFUser.currentUser()!)
                        self.likesIconImageView.hidden = (value.count == 0)
                    } else {
                        self.likesLabel.text = ""
                        self.likeButton.selected = false
                        self.likesIconImageView.hidden = false
                    }
                }
            }
        }
    }

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var likesIconImageView: UIImageView!
    @IBOutlet weak var postImageView: UIImageView!
    
    var postDisposable: DisposableType?
    var likeDisposable: DisposableType?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func moreButtonTapped(sender: AnyObject) {
    }

    @IBAction func likeButtonTapped(sender: AnyObject) {
        post?.toggleLikePost(PFUser.currentUser()!)
    }
    
    // Generates a  comma seperated list of usernames from an array.(e.g. "User1, User2")
    func stringFromUserList(userList: [PFUser]) -> String {
        let usernameList = userList.map { user in user.username! }
        let commaSeperatedUserList = usernameList.joinWithSeparator(", ")
        
        return commaSeperatedUserList
    }
}
