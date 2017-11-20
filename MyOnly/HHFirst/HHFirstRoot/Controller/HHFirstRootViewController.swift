//
//  HHFirstRootViewController.swift
//  MyOnly
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 macZh. All rights reserved.
//

import UIKit
import Hero

class HHFirstRootViewController: UIViewController {
    
    @IBOutlet weak var rootTabvc: UITableView!
    
    var storyboards: [String] =  ["HHHeroRootViewController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension HHFirstRootViewController {
    
    func initAll() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "china"), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.topItem?.title = "Just"
        
        self.rootTabvc.tableFooterView = UIView()
        self.rootTabvc.delegate = self
        self.rootTabvc.dataSource = self
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.automaticallyAdjustsScrollViewInsets = false
        self.rootTabvc.register(UINib.init(nibName: "HHFirstRootTableViewCell", bundle: nil), forCellReuseIdentifier: "RootCell")
    }
    
}

extension HHFirstRootViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyboards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rootTabvc.dequeueReusableCell(withIdentifier: "RootCell", for: indexPath) as! HHFirstRootTableViewCell
        cell.titleLabel.text = storyboards[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.rootTabvc.deselectRow(at: indexPath, animated: true)
        let vc = HHHeroRootViewController()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
