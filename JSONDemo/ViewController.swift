//
//  ViewController.swift
//  JSONDemo
//
//  Created by Charles Hsu on 1/20/15.
//  Copyright (c) 2015 Loxoll. All rights reserved.
//

import UIKit

let kLastestTaipeiBusLocationURL = "http://data.ntpc.gov.tw/NTPC/od/data/api/CE74A94B-36D2-4482-A25D-670625ED0678?$format=json"
let kTaipeiBusStationURL = "http://data.ntpc.gov.tw/NTPC/od/data/api/18621BF3-6B00-4A07-B49C-0C5CCABFE026?$format=json"

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let qualityOfServiceClass = QOS_CLASS_BACKGROUND
    let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
    dispatch_async(backgroundQueue, {
      // This is run on the background queue
      println("This is run on the background queue")
      let url = NSURL(string: kLastestTaipeiBusLocationURL)
      let data = NSData(contentsOfURL: url!)
      self.fetchedData(data!)
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        // This is run on the main queue, after the previous code in outer block
        println("This is run on the main queue, after the previous code in outer block")
      })
    })
  
  }

  func fetchedData(var data: NSData) {
    // parse out the json data
    println(data)
    var error: NSError?
    
    if let json = NSJSONSerialization.JSONObjectWithData(data,
      options: nil, error: &error) as? NSArray {
      println(json)
    } else {
      if let unwrapperError = error {
        println("json error: \(unwrapperError)")
      }
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func shouldAutorotate() -> Bool {
    return false
  }

  

}

