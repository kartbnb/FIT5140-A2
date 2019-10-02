//
//  ViewController.swift
//  FIT5140-A2
//
//  Created by 佟诗博 on 2/10/19.
//  Copyright © 2019 佟诗博. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    weak var firebaseController: FirebaseController?
    var model: TempColorModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get firebaseController from app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        firebaseController = appDelegate.firebaseController
        setupUI()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //firebaseController?.loadService(self)
        firebaseController?.fetchSources()
        model = firebaseController?.tempcolorModel
    }
    
    func setupUI() {
        print(model)
        if let m = model {
            colorView.backgroundColor = model?.color
            tempLabel.text = model?.temperature
        } else{
            tempLabel.text = "nothing"
            colorView.backgroundColor = UIColor(red: 1, green: 1, blue: 0, alpha: 1)
        }
        
    }
    
//    func loadSource(model: TempColorModel) {
//        self.model = model
//        view.reloadInputViews()
//    }


}

