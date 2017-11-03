//
//  TTViewController.swift
//  MyOnly
//
//  Created by mac on 2017/11/2.
//  Copyright © 2017年 macZh. All rights reserved.
//

import UIKit

class TTViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hero_unwindToRootViewController)))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    

}
