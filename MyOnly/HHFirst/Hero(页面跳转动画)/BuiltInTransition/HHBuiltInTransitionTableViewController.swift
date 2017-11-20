//
//  HHBuiltInTransitionTableViewController.swift
//  MyOnly
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 macZh. All rights reserved.
//

import UIKit
import Hero

class HHBuiltInTransitionTableViewController: UITableViewController {

    var animations: [HeroDefaultAnimationType] = [
        .push(direction: .left),
        .push(direction: .right),
        .push(direction: .up),
        .push(direction: .down),
        .pull(direction: .left),
        .pull(direction: .right),
        .pull(direction: .up),
        .pull(direction: .down),
        .slide(direction: .left),
        .slide(direction: .right),
        .slide(direction: .up),
        .slide(direction: .down),
        .zoomSlide(direction: .left),
        .zoomSlide(direction: .right),
        .zoomSlide(direction: .up),
        .zoomSlide(direction: .down),
        .cover(direction: .up),
        .cover(direction: .right),
        .cover(direction: .up),
        .cover(direction: .down),
        .uncover(direction: .up),
        .uncover(direction: .right),
        .uncover(direction: .up),
        .uncover(direction: .down),
        .pageIn(direction: .left),
        .pageIn(direction: .right),
        .pageIn(direction: .up),
        .pageIn(direction: .down),
        .pageOut(direction: .left),
        .pageOut(direction: .right),
        .pageOut(direction: .up),
        .pageOut(direction: .down),
        .fade,
        .zoom,
        .zoomOut,
        .none,
        ]
    
    var labelColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.randomColor
        labelColor = self.tableView.backgroundColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    deinit {
        HHLog.info("页面释放")
    }

}

extension HHBuiltInTransitionTableViewController {
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : animations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let header = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)
            return header
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BuiltInTransitionCell", for: indexPath)
        cell.textLabel?.text = animations[indexPath.item].label
        cell.backgroundColor = labelColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "HHBuiltInTransition")
        vc.heroModalAnimationType = animations[indexPath.item]
        hero_replaceViewController(with: vc)
    }
    
}
