//
//  FireBaseManger.swift
//  Chat_App
//
//  Created by Visakh D on 18/03/25.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestoreInternal



class FirebaseManager : NSObject {
    
    let auth : Auth
    let storage : Storage
    let fireStore : Firestore

    
    static let shared  = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.fireStore = Firestore.firestore()
        super.init()
    }
}
