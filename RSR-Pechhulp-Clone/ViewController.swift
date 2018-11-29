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
    
    @IBOutlet weak var overButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        // Set status bar color to white
        UIApplication.shared.statusBarStyle = .lightContent
        
        // If iPad - hide info button on navbar else hide over button on iPhone
         if UIDevice.current.userInterfaceIdiom == .pad {
            
            self.navigationItem.rightBarButtonItem = nil
            
         } else {
            self.overButton.isHidden = true
        }
        
    }
}


