//
//  Constants.swift
//  Comment Manager
//
//  Created by Hizami Rashid on 14/01/2020.
//  Copyright © 2020 Hizami Rashid. All rights reserved.
//

import Foundation
import UIKit

enum Env {
    case development
    case staging
    case production
}

struct Constants {
    
    struct API {
        static let baseURL = "https://jsonplaceholder.typicode.com/"
        static let grant_type = ""
        static let client_id = ""
        static let secret = ""
        static let authorizarionBase64 = ""
        
        struct Endpoint {
            static let getPosts = "posts"
            static let getPost = "posts/"
            static let getComments = "comments?postId="
        }
        
        struct ParameterKeyNames {
            
            // header
            static let kAuthorization = "Authorization"
            
            //login
            static let kUsername = "username"
            static let kClient_id = "client_id"
            static let kPassword = "password"
            static let kSecret = "secret"
            static let kGrant_type = "grant_type"
            
            //getprofile
            static let kAccess_token = "access_token"
            static let kRefresh_token = "refresh_token"
            static let kScope = "scope"
            static let kToken_type = "token_type"
            static let kUserDetailID = "userDetailID"
            static let kWorkshopDetailID = "workshopDetailID"
        }
    }
    
    struct Device {
        static let osType = "ios"
        static let osVersion = UIDevice.current.systemVersion
        static let isIPhone = (UIDevice.current.userInterfaceIdiom == .phone)
        static let isIPad = (UIDevice.current.userInterfaceIdiom == .pad)
        static let isIPhone5OrLess = (isIPhone && screenMaxLength <= 568.0)
        static let screenScale = UIScreen.main.scale
        static let screenHeight = UIScreen.main.bounds.size.height
        static let screenWidth = UIScreen.main.bounds.size.width
        static let screenMaxLength = max(screenWidth, screenHeight)
        static let screenMinLength = min(screenWidth, screenHeight)
    }
    
    struct App {
        static let bundleId = Bundle.main.bundleIdentifier
        static let name = Bundle.main.object(forInfoDictionaryKey:"CFBundleDisplayName")! as! String
        static let version = Bundle.main.object(forInfoDictionaryKey:"CFBundleShortVersionString")! as! String
        static let build = Bundle.main.object(forInfoDictionaryKey:"CFBundleVersion")! as! String
    }
    
    struct Storyboard {
        static let main = "Main"
    }
    
    struct Sizes {
        
    }
    
    struct Segue {
        
    }
    
    struct AlertView {
    }
    
    struct Titles {
        static let error = "Error"
        static let successful = "Successful"
        static let warning = "Warning"
    }
    
    struct Buttons {
        static let ok = "OK"
        static let cancel = "Cancel"
        static let yes = "YES"
        static let no = "NO"
    }
    
    struct Logs {
        static let jsonParsingStatusMessageError = "Error in parsing status or message"
        static let jsonParsingResonseDataError = "Error in parsing response data"
        static let jsonConvertingError = "Error in converting JSON to data to object model"
    }
    
    struct Keys {
        
    }
    
    struct Placeholders {
        
    }
    
    struct Messages {
        static let loading = "Please Wait..."
        static let apiError = "There was an error in the server. Please try again later."
        static let connectionError = "There is no internet connection. Please try again later."
        static let invalidEmailError = "Email format is invalid."
        static let emptyFieldsError = "Please fill-up all the fields."
        static let invalidConfirmPassword = "The password you entered does not match."
        static let exitSpacerSetupError = "Are you sure you want to exit the Spacer setup?"
        
        static func emptyFieldsErrorSpecific(field : String)-> String {
            return "Please enter \(field)."
        }
        
        static func emptyChildFieldsErrorSpecific(field : String)-> String {
            return "Please enter your child's \(field)."
        }
    }
    
    struct Colors {
        static let redError = 0xd42027
    }
    
    struct Strings {
        
        /**
         * This struct stores string constants used within the app.
         * All strings that are shown to the user should be placed
         * in this struct.
         */
        
        struct Errors {
            static let standardTitle = "Oops"
            static let standardError = "Something went wrong. Please try again later"
            static let connectionError = "It seems that there are some problems with your internet connection. Please try again later."
            static let authenticationError = "You have been logged out. Please relogin again."
            
            static let loginEmpty = "Please enter your IC Number and password to continue."
            static let registrationEmpty = "Please ensure to fill up all fields to continue."
            static let forgotPasswordEmpty = "Please enter your email to proceed"
            static let invalidEmail = "Please enter a valid email address"
            static let passwordMismatch = "Please ensure your password and confirm password match"
            static let tncNotAccepted = "Please accept the terms & conditions to proceed"
        }
        
        struct General {
            static let emptyString = ""
            static let cancel = "Cancel"
        }
    }
}
