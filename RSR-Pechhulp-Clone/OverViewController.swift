//
//  OverViewController.swift
//  RSR-Pechhulp-Clone
//
//  Created by Shane Walsh on 28/11/2018.
//  Copyright © 2018 Shane Walsh. All rights reserved.
//

import UIKit

class OverViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // If iPad hide info button on navbar
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            self.logoImageView = nil
        }
        
    }
}
