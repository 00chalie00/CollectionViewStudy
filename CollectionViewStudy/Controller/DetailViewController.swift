//
//  DetailViewController.swift
//  CollectionViewStudy
//
//  Created by formathead on 2020/03/24.
//  Copyright © 2020 formathead. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailLabel: UILabel?
    
    var detailText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailLabel?.text = detailText
        
    }

}
