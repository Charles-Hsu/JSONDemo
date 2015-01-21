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
let kTaipeiBusRouteURL = "http://data.ntpc.gov.tw/NTPC/od/data/api/5D3B5FE3-549A-40D5-8FA3-0C691230B213?$format=json"

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let qualityOfServiceClass = QOS_CLASS_BACKGROUND
    let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
    dispatch_async(backgroundQueue, {
      // This is run on the background queue
      println("This is run on the background queue")
      //let url = NSURL(string: kLastestTaipeiBusLocationURL)
      let url = NSURL(string: kTaipeiBusStationURL)
      let data = NSData(contentsOfURL: url!)
      self.fetchedData(data!)
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        // This is run on the main queue, after the previous code in outer block
        println("This is run on the main queue, after the previous code in outer block")
      })
    })
  
  }

//  {
//  EstimateTime = 2;
//  Memo = "";
//  RouteID = 113;
//  StationId = 4002;
//  }

//  {
//  "Provider_Id" = 100;
//  "Provider_nameEn" = "";
//  "Provider_nameZh" = "\U53f0\U5317\U5ba2\U904b";
//  "Provider_type" = 0;
//  "Route_En" = "";
//  "Route_Id" = 113;
//  "Route_SID" = "";
//  "Route_TSI" = "";
//  "Route_departureEn" = "Daren Rd.";
//  "Route_departureZh" = "\U5927\U4ec1\U8def";
//  "Route_destinationEn" = "Daren Rd.";
//  "Route_destinationZh" = "\U5927\U4ec1\U8def";
//  "Route_nameZh" = 812;
//  "Route_opBD" = "";
//  "Route_opED" = "";
//  "Route_providerId" = 100;
//  "Route_sbTime" = "";
//  "Route_seTime" = "";
//  "Route_status" = 1;
//  "Route_type" = 0;
//  "Station_Id" = 4002;
//  "Station_address" = "";
//  "Station_districtId" = 2;
//  "Station_goBack" = 0;
//  "Station_latitude" = "24.936684";
//  "Station_longitude" = "121.36432";
//  "Station_nameEn" = "Daren Rd.";
//  "Station_nameZh" = "\U5927\U4ec1\U8def";
//  "Station_pgp" = 0;
//  "Station_routeId" = 113;
//  "Station_seqNo" = 1;
//  "Station_terminal" = 0;
//  "Station_ticketId" = "";
//}

  func fetchStationData() {
    let url = NSURL(string: kTaipeiBusStationURL)
    let data = NSData(contentsOfURL: url!)
    self.fetchedData(data!)
  }
  
  func fetchCurrentLocationData() {
    let url = NSURL(string: kLastestTaipeiBusLocationURL)
    let data = NSData(contentsOfURL: url!)
    self.fetchedData(data!)
  }

  func fetchedData(var data: NSData) /*-> NSArray*/ {
    // parse out the json data
    //println(data)
    var error: NSError?
    
    if let json = NSJSONSerialization.JSONObjectWithData(data,
      options: nil, error: &error) as? NSArray {
        for var i = 0; i < json.count; i++ {
          let station = json[i] as NSDictionary
          //for var j=0; j < json[i].coun
          //println(station["Station_nameZh"] as String!)
          println(station)
        }
      //println(json)
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

