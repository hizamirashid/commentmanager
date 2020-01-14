//
//  ViewController.swift
//  Comment Manager
//
//  Created by Hizami Rashid on 14/01/2020.
//  Copyright © 2020 Hizami Rashid. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    var postsModel: [PostModel]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "All Posts"
        
        getPosts()
    }

}


// MARK: - APIs
extension ViewController {
    
    func getPosts() {
        APIHelper.shared.getPosts(viewController: self) { (result, statusCode, postsModel, message) in
            
            guard result.isSuccess == true
                else {
                    // Show error message
                    guard let error = message else { return }
                    
                    self.showErrorAlert(message: error)
                    return
            }
            
            self.postsModel = postsModel
            APIHelper.shared.hideLoadingActivity(self)
            
            // reload tableview
            self.tableView.reloadData()
            
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = postsModel[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = CommentsViewController.getInstance()
        vc.postModel = postsModel[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
