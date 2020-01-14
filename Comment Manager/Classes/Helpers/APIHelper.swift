//
//  APIHelper.swift
//  Comment Manager
//
//  Created by Hizami Rashid on 14/01/2020.
//  Copyright © 2020 Hizami Rashid. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class APIHelper: NSObject {
    
    static let shared = APIHelper()
    let userdefaults = UserDefaults.standard
    
    // MARK: - Reachability and Network Connection
    static func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    // MARK: - Activity Indicator
    var activityIndicator: NVActivityIndicatorView?
    func showLoadingActivity(_ viewController: UIViewController) {
        if activityIndicator == nil {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            activityIndicator = NVActivityIndicatorView(frame: CGRect(x:0, y:0, width:(appDelegate.window?.bounds.width)!, height:(appDelegate.window?.bounds.height)!), type: NVActivityIndicatorType.circleStrokeSpin, color: UIColor.black, padding: (appDelegate.window?.bounds.width)!/2-25)
            activityIndicator?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
            activityIndicator?.layer.cornerRadius = 0
            
            if let window = appDelegate.window {
                window.addSubview(activityIndicator!)
            } else { viewController.view.addSubview(activityIndicator!) }
            viewController.view.isUserInteractionEnabled = false
            activityIndicator?.startAnimating()
        }
    }
    
    func hideLoadingActivity(_ viewController: UIViewController) {
        if activityIndicator != nil {
            activityIndicator?.stopAnimating()
            activityIndicator?.removeFromSuperview()
            activityIndicator = nil
            viewController.view.isUserInteractionEnabled = true
        }
    }
    
    // MARK:- API CALL
    
    // Get posts
    func getPosts(viewController: UIViewController, completion: @escaping (_ handleError: Result<Any>, _ statusCode: Int?, _ postModel: [PostModel]?, _ errorMessage: String?) -> ()) {
        
        let url = Constants.API.baseURL + Constants.API.Endpoint.getPosts
        print(url)
        
        let params: Parameters = [:]
        
        self.showLoadingActivity(viewController)
        if !APIHelper.isConnectedToInternet() {
            hideLoadingActivity(viewController)
            return
        }
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default).validate(statusCode: 200..<300).responseJSON { (response) in
            
            self.hideLoadingActivity(viewController)
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let jsonDecoder = JSONDecoder()
                
                if json == JSON.null {
                    completion(response.result, response.response?.statusCode, nil, Constants.Messages.apiError)
                    return
                }
                guard let jsonData = try? JSONSerialization.data(withJSONObject: json.arrayObject!, options: .prettyPrinted),
                    let decodedUserObj = try? jsonDecoder.decode([PostModel].self, from: jsonData)
                    else{
                        
                        completion(response.result, response.response?.statusCode, nil, Constants.Messages.apiError)
                        return
                }
                
                completion(response.result, response.response?.statusCode, decodedUserObj, "")
                
            case .failure(let error):
                print(error)
                
                viewController.showErrorAlert(message: "\(error.localizedDescription)")
            }
        }
    }
    
    func getComments(viewController: UIViewController, id: Int, completion: @escaping (_ handleError: Result<Any>, _ statusCode: Int?, _ commentsModel: [CommentModel]?, _ errorMessage: String?) -> ()) {
        
        let url = Constants.API.baseURL + Constants.API.Endpoint.getComments + "\(id)"
        print(url)
        
        let params: Parameters = [:]
        
        self.showLoadingActivity(viewController)
        if !APIHelper.isConnectedToInternet() {
            hideLoadingActivity(viewController)
            return
        }
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default).validate(statusCode: 200..<300).responseJSON { (response) in
            
            self.hideLoadingActivity(viewController)
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let jsonDecoder = JSONDecoder()
                
                if json == JSON.null {
                    completion(response.result, response.response?.statusCode, nil, Constants.Messages.apiError)
                    return
                }
                guard let jsonData = try? JSONSerialization.data(withJSONObject: json.arrayObject!, options: .prettyPrinted),
                    let decodedUserObj = try? jsonDecoder.decode([CommentModel].self, from: jsonData)
                    else{
                        
                        completion(response.result, response.response?.statusCode, nil, Constants.Messages.apiError)
                        return
                }
                
                completion(response.result, response.response?.statusCode, decodedUserObj, "")
                
            case .failure(let error):
                print(error)
                
                viewController.showErrorAlert(message: "\(error.localizedDescription)")
            }
        }
    }
}
