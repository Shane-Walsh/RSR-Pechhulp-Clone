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

        // If iPhone - hide logo image
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            self.logoImageView.isHidden = true
        }        
    }
}
