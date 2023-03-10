//
//  HDDemoRosterController.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/3/9.
//  Copyright © 2023 Hegk. All rights reserved.
//

import Foundation
import CoreImage
import UIKit
/*
    Q :self.rosters.append(roster) 和 self.tableView.reloadData() 解决block中的循环引用的原理是什么
 */

let dataSourceUrl = URL(string: "https://www.raywenderlich.com/downloads/ClassicPhotosDictionary.plist")


class HDDemoRosterController: HDBaseViewController {
    
    
    
    
    var rosters = [HDDemoRoster]()
    var pendingOperations = HDDemoPendingOperations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "roster"
        
        view.addSubview(tableView)
        downData()
        
    }
    
    func downData() {
        let request = URLRequest(url: dataSourceUrl!)
        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            if let error = error {
                self.alertController(errorMsg: error.localizedDescription)
                return
            }
            
            // 获取httpResponse
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP response status code: \(httpResponse.statusCode)")
            }
            
            if let data = data {
                do {
                    if let dict = try PropertyListSerialization.propertyList(from: data, options: PropertyListSerialization.ReadOptions(rawValue: 0), format: nil) as? [String : AnyObject] {
                        
                        for (name, url) in dict {
                            if let url = URL(string: url as! String) {
                                let roster = HDDemoRoster(name: name, url: url)
                                self.rosters.append(roster)
                            }
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                } catch let error as NSError {
                    print(error.domain)
                }
            }
        }
        
        // 启动task
        task.resume()
    }
    
    private func alertController(errorMsg: String) {
        let alertController = UIAlertController(title: "Oops", message: errorMsg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alertController.addAction(okAction)
        navigationController!.present(alertController, animated: true, completion: nil)
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kNavigationtBarAndStatuBarHeight)

        tableView.delegate   = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor    = .white
        tableView.separatorStyle     = .singleLine
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCellID")
        return tableView
    }()
    
    
}

extension HDDemoRosterController {
    fileprivate func startOperationsForResource(roster: HDDemoRoster, indexPath: IndexPath) {
        switch(roster.state) {
        case .New:
            startDownloadForResource(roster: roster, indexPath: indexPath)
        case.Downloaded:
            startFiltrationForResource(roster: roster, indexPath: indexPath)
        default:
            NSLog("do nothing")
        }
    }
    
    fileprivate func startDownloadForResource(roster: HDDemoRoster, indexPath: IndexPath) {
        if let _ = pendingOperations.downloadsInProgress[indexPath] {
            return
        }
        
        let downloader = ImageDownloader(roster: roster)
        
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            
            DispatchQueue.main.async {
                self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
    
    fileprivate func startFiltrationForResource(roster: HDDemoRoster, indexPath: IndexPath) {
        if let _ = pendingOperations.filtrationsInProgress[indexPath] {
            return
        }
        
        let downloader = ImageFiltration(roster: roster)
        
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            
            DispatchQueue.main.async {
                self.pendingOperations.filtrationsInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        
        pendingOperations.filtrationsInProgress[indexPath] = downloader
        pendingOperations.filtrationQueue.addOperation(downloader)
    }
}

extension HDDemoRosterController {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        suspendAllOperations()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            loadImagesForOnscreenCells()
            resumeAllOperations()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImagesForOnscreenCells()
        resumeAllOperations()
    }
    
    fileprivate func suspendAllOperations () {
        pendingOperations.downloadQueue.isSuspended = true
        pendingOperations.filtrationQueue.isSuspended = true
    }
    
    fileprivate func resumeAllOperations () {
        pendingOperations.downloadQueue.isSuspended = false
        pendingOperations.filtrationQueue.isSuspended = false
    }
    
    fileprivate func loadImagesForOnscreenCells () {
        if let pathsArray = tableView.indexPathsForVisibleRows {
          
          var allPendingOperations = Set(pendingOperations.downloadsInProgress.keys)
          allPendingOperations = allPendingOperations.union(pendingOperations.filtrationsInProgress.keys)
          
          // get cells should cancel operations
          var toBeCancelled = allPendingOperations
          let visiblePaths = Set(pathsArray)
          toBeCancelled.subtract(visiblePaths)
          
          // get cells should be started as new
          var toBeStarted = visiblePaths
          toBeStarted.subtract(allPendingOperations)
          
          // cancel download and filter operations for unvisible cells
          for indexPath in toBeCancelled {
            if let pendingDownload = pendingOperations.downloadsInProgress[indexPath] {
              pendingDownload.cancel()
            }
            pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
            if let pendingFiltration = pendingOperations.filtrationsInProgress[indexPath] {
              pendingFiltration.cancel()
            }
            pendingOperations.filtrationsInProgress.removeValue(forKey: indexPath)
          }
          
          // start operation for new visible cells
          for indexPath in toBeStarted {
            let roster = self.rosters[indexPath.row]
            startOperationsForResource(roster: roster, indexPath: indexPath)
          }
        }
      }
}


extension HDDemoRosterController: UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rosters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellID", for: indexPath)
        let roster = rosters[indexPath.row]

        if cell.accessoryView == nil {
            let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
            cell.accessoryView = indicator
        }
        
        let indicator = cell.accessoryView as! UIActivityIndicatorView
        
        switch (roster.state){
        case .Filtered:
          indicator.stopAnimating()
        case .Failed:
          indicator.stopAnimating()
          cell.textLabel?.text = "Failed to load"
        case .New, .Downloaded:
          indicator.startAnimating()
          if (!tableView.isDragging && !tableView.isDecelerating) {
            self.startOperationsForResource(roster: roster, indexPath: indexPath)
          }
        }
        
        cell.textLabel?.text = roster.name
        cell.imageView?.image = roster.image
        return cell
    }
}
