//
//  FirebaseController.swift
//  FIT5140-A2
//
//  Created by 佟诗博 on 2/10/19.
//  Copyright © 2019 佟诗博. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirebaseController: NSObject {
    
    var authController: Auth
    var database: Firestore
    var tempRef: CollectionReference?
    var rgbRef: CollectionReference?
    var tempcolorModel: TempColorModel
    
    override init() {
        // To use Firebase in our application we first must run the FirebaseApp configure method
        FirebaseApp.configure()
        // We call auth and firestore to get access to these frameworks
        authController = Auth.auth()
        database = Firestore.firestore()
        tempcolorModel = TempColorModel()
        super.init()
        authController.signInAnonymously() {(authResult, error) in
            guard authResult != nil else {
                fatalError("Firebase authentication failed")
            }
            self.fetchSources()
        }
        
        
    }
    
    func fetchSources() {
        tempRef = database.collection("temperature")
        tempRef?.addSnapshotListener { querysnapshot, error in
            guard (querysnapshot?.documents) != nil else {
                print("Error fetching documents: \(error)")
                return
            }
            self.parseTempSnapshot(snapshot: querysnapshot!)
        }
        
    }
    
    func parseTempSnapshot(snapshot: QuerySnapshot) {
        snapshot.documents.forEach { doc in
            let documentRef = doc.documentID
            if documentRef == "current" {
                let tempStr = doc.data()["temperature"] as! String
                print(tempStr)
                tempcolorModel.temperature = "26"
                let red = doc.data()["red"] as! Int
                let green = doc.data()["green"] as! Int
                let blue = doc.data()["blue"] as! Int
                tempcolorModel.color = UIColor.init(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0), alpha: CGFloat(0))
            }
            
        }
    }
    
    func loadService(_ load: LoadingSource){
        load.loadSource(model: tempcolorModel)
    }

}

protocol LoadingSource {
    func loadSource(model: TempColorModel)
}
