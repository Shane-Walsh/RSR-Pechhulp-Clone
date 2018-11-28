//
//  ViewController.swift
//  RSR-Pechhulp-Clone
//
//  Created by Shane Walsh on 16/10/2018.
//  Copyright © 2018 Shane Walsh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var infoButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set status bar color to white
        UIApplication.shared.statusBarStyle = .lightContent
        
        
        // If iPad hide info button on navbar
         if UIDevice.current.userInterfaceIdiom == .pad {
            
            self.navigationItem.rightBarButtonItem = nil
         }
    }
}


