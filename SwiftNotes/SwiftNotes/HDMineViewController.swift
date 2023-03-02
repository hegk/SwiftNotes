//
//  HDMineViewController.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/2/28.
//  Copyright © 2023 Hegk. All rights reserved.
//

import Foundation

class HDMineViewController: HDBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init(title: NSString?) {
        super.init(nibName: nil, bundle: nil)
        self.title = title as String?
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
