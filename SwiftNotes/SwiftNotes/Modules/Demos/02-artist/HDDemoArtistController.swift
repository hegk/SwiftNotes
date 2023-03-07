//
//  HDDemoArtistController.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/3/5.
//  Copyright © 2023 Hegk. All rights reserved.
//

import Foundation
import UIKit

class HDDemoArtistController: HDBaseViewController {
    
    let artists = HDDemoArtist.artistsFromBundle()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kNavigationtBarAndStatuBarHeight)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.register(UINib(nibName: "HDDemoArtistCell", bundle: nil), forCellReuseIdentifier: HDDemoArtistCell.indentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "DemoArtist"
        
        
        view.addSubview(tableView)
    }
}

extension HDDemoArtistController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HDDemoArtistDetailController()
        vc.artist = artists[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HDDemoArtistController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let artist = artists[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: HDDemoArtistCell.indentifier) as! HDDemoArtistCell
        cell.addData(artist: artist)
        return cell
    }
    
    
}



