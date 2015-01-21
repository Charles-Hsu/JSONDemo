# JSONDemo

- [新北市公車到站預估資料](http://data.taipei.gov.tw/opendata/apply/RelatedUrl?url=http%3A%2F%2Fdata.ntpc.gov.tw%2FNTPC%2Fod%2Fdata%2Fapi%2Fmeta%2F%3F%24format%3Djson&%24filter=oid+eq+CE74A94B-36D2-4482-A25D-670625ED0678)

- [新北市公車站牌資料](http://data.taipei.gov.tw/opendata/apply/RelatedUrl?url=http://data.ntpc.gov.tw/NTPC/od/data/api/meta/?$format=json&$filter=oid%20eq%2018621BF3-6B00-4A07-B49C-0C5CCABFE026)

- [新北市公車路線清單](http://data.taipei.gov.tw/opendata/apply/RelatedUrl?url=http://data.ntpc.gov.tw/NTPC/od/data/api/meta/?$format=json&$filter=oid%20eq%205D3B5FE3-549A-40D5-8FA3-0C691230B213)

# Getting Started

Open up Xcode and from the main menu choose File\New\New Project. Choose the iOS\Application\Single View Application template, and click Next. Name the product JSONDemo, checked only the Portrait for Device Orientation. Click Next and save the project by clicking Create.

Open the file in Navigation Folder \Supporting Files\Info.plist, delete the items you do not want to supported in Supported interface orientations (iPad). Do a little bit of clean up first – open up ViewController.swift file and replace everything inside with this :

```swift
import UIKit

// 1
let kLastestTaipeiBusLocationURL = "http://data.ntpc.gov.tw/NTPC/od/data/api/CE74A94B-36D2-4482-A25D-670625ED0678?$format=json"

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // 2
  override func shouldAutorotate() -> Bool {
    return false
  }
}
```

Create a constant kLastestTaipeiBusLocationURL, point to http://data.ntpc.gov.tw/NTPC/od/data/api/CE74A94B-36D2-4482-A25D-670625ED0678?$format=json, use your browser to take a look of the JSON content.

Redefine the func shouldAutorotate(), return false instead of the defualt true.

# Parsing JSON from the Web

The first thing we need to do is downloading the JSON data from the web. Add the following code in viewDidLoad().

```swift
let qualityOfServiceClass = QOS_CLASS_BACKGROUND
let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
dispatch_async(backgroundQueue, {
  // This is run on the background queue
  println("This is run on the background queue")
  let url = NSURL(string: kLastestTaipeiBusLocationURL)
  let data = NSData(contentsOfURL: url!)
  println(data)
  // 1
  dispatch_async(dispatch_get_main_queue(), { () -> Void in
    // This is run on the main queue, after the previous code in outer block
    println("This is run on the main queue, after the previous code in outer block")
  })
})
```

Press Alt+R to run the code, you will see the test result. After we fetch the content from URL, we need to compile the data to readable format. So, added following code

```swift
func fetchedData(var data: NSData) {
  // parse out the json data
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
```

# Reference

- Working with JSON in iOS 5 Tutorial(http://www.raywenderlich.com/5492/working-with-json-in-ios-5)
- How to use background thread in swift?(http://stackoverflow.com/questions/24056205/how-to-use-background-thread-in-swift)
- Swift : Loading image from URL (http://stackoverflow.com/questions/24231680/swift-loading-image-from-url)
- Downloading and parsing json in swift (http://stackoverflow.com/questions/24065536/downloading-and-parsing-json-in-swift)
- Swift dynamic cast failed with HTTP GET request(http://stackoverflow.com/questions/24956956/swift-dynamic-cast-failed-with-http-get-request)
- Using Swift to unescape unicode characters, ie \u1234(http://stackoverflow.com/questions/24318171/using-swift-to-unescape-unicode-characters-ie-u1234)
