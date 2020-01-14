//
//  CommentsViewController.swift
//  Comment Manager
//
//  Created by Hizami Rashid on 14/01/2020.
//  Copyright © 2020 Hizami Rashid. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var postModel: PostModel?
    var commentsModel: [CommentModel]! = []

    // MARK: - Instance
    static func getInstance() -> CommentsViewController {
        let sb = UIStoryboard.init(name: Constants.Storyboard.main, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
        return vc
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let post = postModel, let id = post.id else {
            self.showErrorAlert(message: "invalid posts")
            return
        }
        
        getComments(id: id)
        
    }
    
}

// MARK: - APIs
extension CommentsViewController {
    
    func getComments(id: Int) {
        APIHelper.shared.getComments(viewController: self, id: id) { (result, statusCode, CommentsModel, message) in
            
            guard result.isSuccess == true
                else {
                    // Show error message
                    guard let error = message else { return }
                    
                    self.showErrorAlert(message: error)
                    return
            }
            
            self.commentsModel = CommentsModel
            APIHelper.shared.hideLoadingActivity(self)
            
            // reload tableview
            self.tableView.reloadData()
            
        }
    }
    
}

extension CommentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return commentsModel.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 {
            
            cell.textLabel?.text = self.postModel?.title
            cell.detailTextLabel?.text = self.postModel?.body
            
        } else {
            
            cell.textLabel?.text = self.commentsModel[indexPath.row].name! + "\n" + self.commentsModel[indexPath.row].email!
            cell.detailTextLabel?.text = self.commentsModel[indexPath.row].body ?? ""
        }
        
        return cell
    }
    
    
    
}
