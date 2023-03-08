//
//  HDDemoCarouselController.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/3/8.
//  Copyright © 2023 Hegk. All rights reserved.
//

import Foundation
import UIKit

class HDDemoCarouselController: HDBaseViewController {
    
    fileprivate var infos = HDDemoCarouselInfo.createInfos()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 340)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: kScreenWidth, height: 320), collectionViewLayout: layout)
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.register(HDDemoCarouselCell.self, forCellWithReuseIdentifier: HDDemoCarouselCell.indentifier)

        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(collectionView)
    }
}

extension HDDemoCarouselController: UICollectionViewDelegate {
    
}

extension HDDemoCarouselController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HDDemoCarouselCell.indentifier, for: indexPath) as! HDDemoCarouselCell
        cell.info = infos[indexPath.row]
        return cell
    }
    
    
}

extension HDDemoCarouselController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
      let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
      let cellWidthWithSpace = layout.itemSize.width + layout.minimumLineSpacing
      
      var offset = targetContentOffset.pointee
      
      let index = (offset.x + scrollView.contentInset.left) / cellWidthWithSpace
      let roundedIndex = round(index)
      
      offset = CGPoint(x: roundedIndex * cellWidthWithSpace - scrollView.contentInset.left, y: -scrollView.contentInset.top)
    }
}
