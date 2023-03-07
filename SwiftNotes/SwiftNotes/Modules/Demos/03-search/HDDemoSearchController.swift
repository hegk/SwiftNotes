//
//  HDDemoSearchController.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/3/7.
//  Copyright © 2023 Hegk. All rights reserved.
//


/*
 Q:
 filter
 字符串拼接
 UISearchResultsUpdating
 UISearchBarDelegate
 
 Q:indexPath.row VC (indexPath as NSIndexPath).row
 Q:CellStyle  and  cell?.detailTextLabel
 
 
 
 */

import Foundation
import UIKit

class HDDemoSearchController: UITableViewController {
    
    
    
    var infos = [HDDemoSearchInfo]()
    var filteredInfos = [HDDemoSearchInfo]()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.standardAppearance.backgroundColor = UIColor(hexString: "#34C872")

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.standardAppearance.backgroundColor = UIColor.systemGroupedBackground

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "srearch"
        infos = [
            HDDemoSearchInfo(category:"Chocolate", name:"Chocolate Bar"),
            HDDemoSearchInfo(category:"Chocolate", name:"Chocolate Chip"),
            HDDemoSearchInfo(category:"Chocolate", name:"Dark Chocolate"),
            HDDemoSearchInfo(category:"Hard", name:"Lollipop"),
            HDDemoSearchInfo(category:"Hard", name:"Candy Cane"),
            HDDemoSearchInfo(category:"Hard", name:"Jaw Breaker"),
            HDDemoSearchInfo(category:"Other", name:"Caramel"),
            HDDemoSearchInfo(category:"Other", name:"Sour Chew"),
            HDDemoSearchInfo(category:"Other", name:"Gummi Bear")
        ]
        
        
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCellID")
        
        addSearchController()
        
    }
    
    func addSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.searchController?.isActive = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredInfos = infos.filter { searchInfo in
            if !(searchInfo.category == scope) && scope != "All" {
                return false
            }
            
            return searchInfo.name.lowercased().contains(searchText.lowercased()) || searchText == ""
        }
        
        tableView.reloadData()
    }
}


extension HDDemoSearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredInfos.count
        }
        return infos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellID")
        if (cell == nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "UITableViewCellID")
        }
        
        
        
        let info: HDDemoSearchInfo
        if searchController.isActive {
            info = filteredInfos[indexPath.row]
        } else {
            info = infos[indexPath.row]
        }
        cell?.textLabel!.text       = info.name
        return cell!
    }
    
}

extension HDDemoSearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
        
    }
}

extension HDDemoSearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
