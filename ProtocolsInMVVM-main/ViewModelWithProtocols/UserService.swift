//
//  UserService.swift
//  ViewModelWithProtocols
//
//  Created by Mert Ziya on 27.12.2024.
//

import Foundation
import FirebaseFirestore


enum UserServiceError : Error {
    case userNotFound
}

class UserService{
    
    static func FetchUser(withid : String , completion: @escaping (Result<User,Error>) -> () ){
        let userCollection = Firestore.firestore().collection("users")
        userCollection.document(withid).getDocument(as: User?.self) { result in
            switch result{
            case .failure(let error):
                completion(.failure(error))
            case .success(let user):
                if let user = user{
                    completion(.success(user))
                }else{
                    completion(.failure(UserServiceError.userNotFound))
                }
            }
        }
    }
    
    
    static func updateUser(
        userId: String,
        userToUpdate: User,
        completion: @escaping (Result<User, Error>) -> ()
    ) {
        let userCollection = Firestore.firestore().collection("users")
    
        // Construct the data to update
        var updateData: [String: Any] = [:]
        if let fullname = userToUpdate.fullname {
            updateData["fullname"] = fullname
        }
        if let username = userToUpdate.username {
            updateData["username"] = username
        }
        
        // Ensure there's something to update
        guard !updateData.isEmpty else {
            completion(.failure(NSError(
                domain: "UpdateError",
                code: 400,
                userInfo: [NSLocalizedDescriptionKey: "No fields to update"]
            )))
            return
        }
        
        userCollection.document(userId).updateData(updateData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                // Return the updated user
                completion(.success(userToUpdate))
            }
        }
    }
     
    
    
    
    
}

/// In this article, it is going to be discussed how Protcol Oriented Programming and Delegate Patterns can be used
/// in order to construct communication while using the MVVM architecture for building apps with swift UIKit.
///
/// Normally, Reactive Programming methodolgies are used for making communicating between View and View Model and binding the UI
/// Components to data that is coming from an API.
///
/// - RxSwift is a popular third-party library that can be used for reactive programming.
/// - Combine is a built-in library that is used for the Reactive Programming. (It is widely used in SwiftUI, possible to use it in UIKit as well).
/// - Protocols are another powerful way to achieve a similiar result. It is not a reactive Programming technology but it is a feature
///     of the swift programming language. Though it is possible to make our application 'reactive' (manually) by using protocols and delegate patterns together with using asynchronous codeblocks. One of the biggest Cons of this approach is it becomes easier to create testing, compared to Combine and RxSwift.
///
/// I Used Firebase as a BaaS(Backend-as-a-Service). So i will be using Firebase while constructing my Service. Here is the function that's goal is to fetch
/// data from the Firebase Firestore and return the fetched data as a 'User' Model. I Gave the Model, Service Class and Firestore collections to understand this part clearer.
///
///
/// [UserViewModel]
///
/// UserViewModel class's function named 'loadUser', fetches the data from firestore and it calls the function protocol functions
/// on completition, UserViewModel is our delegator in our case.
///
/// [UserController]
///
///

/*
 override func viewDidLoad() {
     //...
     viewModel.delegate = self
     fetchButton.addTarget(self, action: #selector(fetchUserData), for: .touchUpInside)
     //...
 }

 @objc private func fetchUserData(){ // Updates the user on each click.
     viewModel.loadUser(withId: "u8GJi17IE79XL4ivcArl") // Example Firebase document ID, not suitable, used or simplicity.
                                                        // Because delegate of viewmodel is assigned to self, this line of code will call the related function wirh loadUser
                                                        // In our case it called didFetchUser since there was no error to call didFailWithError.
 }
 
 class UserController: UIViewController, UserViewModelDelegate{
     private let viewModel = UserViewModel()
     
     func didFetchUser(_ user: User) {
         DispatchQueue.main.async {
             self.username.text = user.username ?? "nil"
             self.fullname.text = user.fullname ?? "nil"
             if let imageUrl = user.imageURL{
                 self.profileImageView.contentMode = .scaleAspectFill
                 self.profileImageView.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(systemName: "photo.circle"))
             }else{print("DEBUG: the url is nil")}
         }
     }
     
     func didFailWithError(_ error: any Error) {
         DispatchQueue.main.async {
             self.username.text = "Error while Fetching"
             self.fullname.text = "Error while Fetching"
             self.profileImageView.image = UIImage(systemName: "person.crop.circle.badge.exclamationmark") // Replace "placeholder" with your image asset name
         }
     }
    //...
 }
 */

