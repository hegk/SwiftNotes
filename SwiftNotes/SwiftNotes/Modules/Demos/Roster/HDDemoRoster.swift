//
//  HDDemoRoster.swift
//  SwiftNotes
//
//  Created by DOVE on 2023/3/9.
//  Copyright © 2023 Hegk. All rights reserved.
//

/*
   Q:class的let   struct的var
 */

import Foundation
import UIKit


enum ResourceState {
    case New, Downloaded, Filtered, Failed
}

class HDDemoRoster {
    let name: String
    let url: URL
    var state = ResourceState.New
    var image = UIImage(named: "artist_placeholder")
    
    init(name: String, url: URL) {
        self.name = name
        self.url  = url
    }
}

struct HDDemoPendingOperations {
    lazy var downloadsInProgress = [IndexPath: Operation]()
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    lazy var filtrationsInProgress = [IndexPath: Operation]()
    lazy var filtrationQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Filtration queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}

class ImageDownloader: Operation {
    let roster: HDDemoRoster
    
    init(roster: HDDemoRoster) {
        self.roster = roster
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        do {
            let images = try Data(contentsOf: roster.url)
            
            if self.isCancelled {
                return
            }
            
            if images.count > 0 {
                roster.image = UIImage(data: images)
                roster.state = .Downloaded
            } else {
                roster.image = UIImage(named: "Faild")
                roster.state = .Failed
            }
            
        } catch let error as NSError {
            print(error.domain)
        }
        
        
    }
}

class ImageFiltration: Operation {
    let roster: HDDemoRoster
    
    init(roster: HDDemoRoster) {
        self.roster = roster
    }
    
    func applySepiaFilter(image: UIImage) -> UIImage? {
        let inputImage = CIImage(data: image.pngData()!)
        if isCancelled {
            return nil
        }
        
        let context = CIContext(options:nil)
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(0.8, forKey: "inputIntensity")
        
        if isCancelled {
          return nil
        }
        
        if let outputImage = filter?.outputImage,
          let outImage = context.createCGImage(outputImage, from: outputImage.extent) {
          return UIImage(cgImage: outImage)
        } else {
          return nil
        }
      }
      
      override func main () {
        if isCancelled {
          return
        }
        
        if self.roster.state != .Downloaded {
          return
        }
        
        if let image = roster.image,
          let filteredImage = applySepiaFilter(image: image) {
          roster.image = filteredImage
          roster.state = .Filtered
        }
      }
}


