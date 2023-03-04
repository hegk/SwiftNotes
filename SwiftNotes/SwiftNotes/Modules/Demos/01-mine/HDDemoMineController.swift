//
//  HDDemoMineController.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/3/4.
//  Copyright © 2023 Hegk. All rights reserved.
//

import Foundation
import UIKit

/*
 
 Q: lazy var 时 一定要用 var 吗
 Q: 非懒加载，为什么      tableView.delegate   = self   不可以用
 private let tableView: UITableView = {
     let tableView = UITableView()
     tableView.delegate   = self
     tableView.dataSource = self
 }()
 Q: as!  as?
 Q: willDisplay 重写的状态会被复用吗
 
 */

class HDDemoMineController: HDBaseViewController {
    typealias RowModel = [String: String]
    
    fileprivate var user: HDDemoMineUser {
        get {
            return HDDemoMineUser(name: "Happy Boy", avatarName: "", education: "kindergarten")
        }
    }
    
    fileprivate var datas: [[String: Any]] {
        get {
            return HDDemoMinePopulate.populate(withUser: user)
        }
    }
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kNavigationtBarAndStatuBarHeight), style: .grouped)
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.register(HDDemoMineCell.self, forCellReuseIdentifier: HDDemoMineCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "DemoMine"
        view.addSubview(tableView)
    }
    
    
    fileprivate func rows(at section: Int) -> [Any] {
        return datas[section][HDDemoMinePopulate.Rows] as! [Any]
    }
    
    fileprivate func sectionTitle(at section: Int) -> String? {
        return datas[section][HDDemoMinePopulate.SectionTitle] as? String
    }

    fileprivate func rowModel(at indexPath: IndexPath) -> RowModel {
        return rows(at: indexPath.section)[indexPath.row] as! RowModel
    }
}


extension HDDemoMineController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows(at: section).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitle(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowModel = rowModel(at: indexPath)
        var cell = HDDemoMineCell()
        
        guard let title = rowModel[HDDemoMinePopulate.Title] else {
            return cell
        }
        if title == user.name {
            cell = HDDemoMineCell.init(style: .subtitle, reuseIdentifier: nil)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: HDDemoMineCell.identifier, for: indexPath) as! HDDemoMineCell
        }
        
        cell.textLabel?.text = title
        if let imageName = rowModel[HDDemoMinePopulate.ImageName] {
            cell.imageView?.image = UIImage(named: imageName)
        } else if title != HDDemoMinePopulate.logout {
            cell.imageView?.image = UIImage(named: "")
        }
        if title == user.name {
            cell.detailTextLabel?.text = rowModel[HDDemoMinePopulate.SubTitle]
        }
        return cell
    }
}

extension HDDemoMineController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowModel = rowModel(at: indexPath)
        
        guard let title = rowModel[HDDemoMinePopulate.Title] else {
            return 0.0
        }
        
        if title == user.name {
            return 64.0
        } else {
            return 44.0
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let rowModel = rowModel(at: indexPath)
        
        guard let title = rowModel[HDDemoMinePopulate.Title] else {
          return
        }
        
        if title == HDDemoMinePopulate.seeMore || title == HDDemoMinePopulate.addFavorites {
            cell.textLabel?.textColor = UIColor(hexInt: 0x3b5998)
            cell.accessoryType = .none
        } else if title == HDDemoMinePopulate.logout {
            cell.textLabel?.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            cell.textLabel?.textColor = UIColor(hexInt: 0x3b5998)
            cell.textLabel?.textAlignment = .center
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .disclosureIndicator
        }
    }
}
