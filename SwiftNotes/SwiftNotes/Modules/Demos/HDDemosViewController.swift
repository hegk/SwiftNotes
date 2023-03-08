//
//  HDDemosViewController.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/2/28.
//  Copyright © 2023 Hegk. All rights reserved.
//

import Foundation
import UIKit

class HDDemosViewController: HDBaseViewController, UITableViewDelegate, UITableViewDataSource {
    static let title_mine = "mine"
    static let title_artist = "artist"
    static let title_search = "search"
    static let title_carousel = "carousel"
    
    fileprivate let demosTitle = [title_mine, title_artist, title_search, title_carousel]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "demos"
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(tableView)
    }
    
   fileprivate lazy var tableView: UITableView = {
       let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kSafeAreaHeight), style: .plain)
       tableView.delegate        = self
       tableView.dataSource      = self
       tableView.separatorStyle  = .singleLine
       tableView.backgroundColor = .clear
       tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCellID")
        return tableView
    }()
}

extension HDDemosViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        demosTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellID", for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.text = demosTitle[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowTitle = demosTitle[indexPath.row]
        switch rowTitle {
        case HDDemosViewController.title_mine:
            navigationController?.pushViewController(HDDemoMineController(), animated: true)
            break
        case HDDemosViewController.title_artist:
            navigationController?.pushViewController(HDDemoArtistController(), animated: true)
            break
        case HDDemosViewController.title_search:
            navigationController?.pushViewController(HDDemoSearchController(), animated: true)
            break
        case HDDemosViewController.title_carousel:
            navigationController?.pushViewController(HDDemoCarouselController(), animated: true)
            break
        default:
            break
        }
    }
    
}
