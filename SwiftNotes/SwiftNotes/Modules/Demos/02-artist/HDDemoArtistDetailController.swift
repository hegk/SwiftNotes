//
//  HDDemoArtistDetailController.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/3/5.
//  Copyright © 2023 Hegk. All rights reserved.
//

/*
    Q:
    let cell = tableView.dequeueReusableCell(withIdentifier: HDDemoWorkCell.indentifier, for: indexPath) as! HDDemoWorkCell
    和let cell = tableView.dequeueReusableCell(withIdentifier: HDDemoWorkCell.indentifier, for: indexPath) 的区别？为什么swift这么安全类型的语言，不多做一点提示
    Q:
    let work = Class
    work.isExpanded = !work.isExpanded   work 为let时，内部可变的成员变量不能被修改的底层原理是什么
    Q:
    tableView.reloadData()
    tableView.beginUpdates()
    tableView.endUpdates()
    的区别
    Q:
    var work = artist.works[indexPath.row]
    work.isExpanded = !work.isExpanded
    artist.works[indexPath.row] = work    Struct和Class的区别
 */

import Foundation
import UIKit

class HDDemoArtistDetailController: HDBaseViewController {
    
    var artist: HDDemoArtist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = artist.name
        
        view.addSubview(tableView)
    }
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kNavigationtBarAndStatuBarHeight)
        tableView.delegate           = self
        tableView.dataSource         = self
        tableView.separatorStyle     = .none
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "HDDemoWorkCell", bundle: nil), forCellReuseIdentifier: HDDemoWorkCell.indentifier)
        return  tableView
    }()
}


extension HDDemoArtistDetailController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var work = artist.works[indexPath.row]
        work.isExpanded = !work.isExpanded
        artist.works[indexPath.row] = work
        
        tableView.reloadData()
//        tableView.beginUpdates()
//        tableView.endUpdates()
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

extension HDDemoArtistDetailController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artist.works.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let work = artist.works[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: HDDemoWorkCell.indentifier, for: indexPath) as! HDDemoWorkCell
        cell.addData(work: work)
        return cell
    }
}



