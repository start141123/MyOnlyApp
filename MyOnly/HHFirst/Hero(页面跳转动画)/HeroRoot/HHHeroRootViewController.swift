//
//  HHHeroRootViewController.swift
//  MyOnly
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 macZh. All rights reserved.
//

import UIKit
import Hero

class HHHeroRootViewController: UIViewController {

    var heroRootvc: UITableView! = nil
    
    var storyboards: [String] =  ["TTViewController",
                                  "HHMenuViewController",
                                  "HHBuiltInTransitionTableViewController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAll()
    }

}

extension HHHeroRootViewController {
    
    func initAll() {
        self.navigationItem.title = "Hero"
        heroRootvc = UITableView.init(frame: UIScreen.main.bounds)
        self.view.addSubview(heroRootvc)
        self.view.backgroundColor = UIColor.clear
        self.heroRootvc.tableFooterView = UIView()
        self.heroRootvc.backgroundColor = UIColor.randomColor
        self.heroRootvc.delegate = self
        self.heroRootvc.dataSource = self
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.automaticallyAdjustsScrollViewInsets = false
        self.heroRootvc.register(UINib.init(nibName: "HHFirstRootTableViewCell", bundle: nil), forCellReuseIdentifier: "RootCell")
    }
    
}

extension HHHeroRootViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyboards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = heroRootvc.dequeueReusableCell(withIdentifier: "RootCell", for: indexPath) as! HHFirstRootTableViewCell
        cell.titleLabel.text = storyboards[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.heroRootvc.deselectRow(at: indexPath, animated: true)
        let storyboardName = storyboards[indexPath.row]
        let vc = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()
        DispatchQueue.main.async {
            self.present(vc!, animated: true, completion: nil)
        }
    }
    
}
