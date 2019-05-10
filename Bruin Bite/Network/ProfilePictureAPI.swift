//
//  ProfilePictureAPI.swift
//  Bruin Bite
//
//  Created by Kameron Carr on 5/9/19.
//  Copyright © 2019 Dont Eat Alone. All rights reserved.
//

import Foundation
import Moya

struct ProfilePictureResponse: Codable {
    let user_id: Int
    let profile_picture: String
}

protocol ProfilePictureUploadDelegate {
    func profilePicture(uploadCompleted: Bool, failedWithError error: String?)
}

protocol ProfilePictureDownloadDelegate {
    func profilePicture(didDownloadimage image: UIImage, forUserWithID userID: Int)
    func profilePicture(failedWithError error: String?)
}

class ProfilePictureAPI {
    
    private let provider = MoyaProvider<MainAPI>()
    
    private let UPLOAD_ERR_MSG = "Couldn't upload profile picture. Try again later"
    private let DOWNLOAD_ERR_MSG = "Couldn't download profile picture. Try again later"
    
    func upload(profilePicture: UIImage, delegate: ProfilePictureUploadDelegate){
        if let data = UIImageJPEGRepresentation(profilePicture, 0.4){
            provider.request(.uploadProfilePicture(image: data)) { (result) in
                switch(result){
                case let .success(response):
                    if response.statusCode == 201 {
                        delegate.profilePicture(uploadCompleted: true, failedWithError: nil)
                    } else {
                        delegate.profilePicture(uploadCompleted: false, failedWithError: self.UPLOAD_ERR_MSG)
                    }
                case let .failure(error):
                    print("Could not upload photo: " + (error.errorDescription ?? ""))
                    delegate.profilePicture(uploadCompleted: false, failedWithError: self.UPLOAD_ERR_MSG)
                }
            }
        }
    }
    
    func download(pictureForUserID userID: Int, delegate: ProfilePictureDownloadDelegate){
        provider.request(.getProfilePicture(forUserWithID: userID)) { (result) in
            switch(result){
            case let .success(response):
                guard let resultStruct : ProfilePictureResponse = try? JSONDecoder().decode(ProfilePictureResponse.self, from: response.data) else {
                    print("Error: Could not decode profile picture response struct.")
                    delegate.profilePicture(failedWithError: self.DOWNLOAD_ERR_MSG)
                    return
                }
                guard let dataDecoded : Data = Data(base64Encoded: resultStruct.profile_picture, options: .ignoreUnknownCharacters), let image = UIImage(data: dataDecoded) else {
                    print("Error: Could not decode profile picture")
                    delegate.profilePicture(failedWithError: self.DOWNLOAD_ERR_MSG)
                    return
                }
                delegate.profilePicture(didDownloadimage: image, forUserWithID: userID)
            case let .failure(error):
                print("Could not download photo: " + (error.errorDescription ?? ""))
                delegate.profilePicture(failedWithError: self.DOWNLOAD_ERR_MSG)
            }
        }
    }
}
