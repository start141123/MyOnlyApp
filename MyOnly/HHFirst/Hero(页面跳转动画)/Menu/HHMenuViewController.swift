//
//  HHMenuViewController.swift
//  MyOnly
//
//  Created by mac on 2017/11/2.
//  Copyright © 2017年 macZh. All rights reserved.
//

import UIKit

class HHMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hero_dismissViewController)))
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MenuPageViewController, let sender = sender as? UIButton {
            sender.heroID = "selected"
            vc.view.heroModifiers = [.source(heroID: "selected")]
            vc.centerBtn.heroID = "selected"
            vc.centerBtn.heroModifiers = [.durationMatchLongest]
            vc.view.backgroundColor = sender.backgroundColor
            vc.centerBtn.setImage(sender.image(for: .normal), for: .normal)
            vc.centerBtn.backgroundColor = sender.backgroundColor
        }
    }
    
}

class MenuPageViewController: UIViewController {
    
    @IBOutlet weak var centerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hero_unwindToRootViewController)))
    }
    
}
