//
//  WeatherTodayViewController.swift
//  SEPA
//
//  Created by Welek Samuel on 19/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit
import MapKit

class WeatherTodayViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var coords = CLLocationCoordinate2D(latitude: 53.4846, longitude: -2.2708)
    var currentTemperature = 0.00
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path: String = NSBundle.mainBundle().pathForResource("day", ofType: "svg")!
        
        let url: NSURL = NSURL.fileURLWithPath(path)  //Creating a URL which points towards our path
        
        //Creating a page request which will load our URL (Which points to our path)
        let request: NSURLRequest = NSURLRequest(URL: url)
        
        
         //webView.scalesPageToFit = false
        
        
   //     let contentSize = webView.scrollView.contentSize;
    //    let webViewSize = webView.bounds.size;
    //    let scaleFactor = webViewSize.width / contentSize.width;
        
     //   webView.scrollView.minimumZoomScale = scaleFactor;
     //   webView.scrollView.maximumZoomScale = scaleFactor;
     //   webView.scrollView.zoomScale = scaleFactor;
        
      
        
        webView.loadRequest(request)  //Telling our webView to load our above request
      
   
   webView.resizeWebContent()

        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(){
        
    }

    
    
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        if (status == .AuthorizedAlways){
            getLocation()
            getWeather { jsonString in
                if let jsonDictionary = self.convertStringToDictionary(jsonString as String){
                    if let currently = jsonDictionary["currently"] as? Dictionary<String, AnyObject>{
                        if let currTemp = currently["temperature"] as? Double{
                            self.currentTemperature = currTemp
                        }
                        dispatch_async(dispatch_get_main_queue()) {
                            self.currentTemp.text = String(format: "%.2f", self.convertToCelsius(self.currentTemperature)) + "°C"
                        }

                        
                    }
                }
            }
            
        } else if (status == .Denied){
            let alert = UIAlertController(title: "Error", message: "Goto Settings and allow this app to access your location", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    func convertToCelsius(fahrenheit: Double) -> Double {
        return Double(5.0 / 9.0 * (Double(fahrenheit) - 32.0))
    }
    
    
    func getLocation(){
        if let loc = locationManager.location?.coordinate{
            coords = loc
        }
    }
    
    func getWeather(completion: (NSString) -> ()) {
        let urlPath = WeatherURL(lat: String(coords.latitude), long: String(coords.longitude)).getFullURL()
        let url: NSURL = NSURL(string: urlPath)!
        let request = NSMutableURLRequest(URL: url)
        
        let session = NSURLSession.sharedSession()
        
        request.HTTPMethod = "GET"
    
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let jsonString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            
            completion(jsonString!)
        })
        
        task.resume()
    }
}


extension UIWebView {
    ///Method to fit content of webview inside webview according to different screen size
    func resizeWebContent() {
        let contentSize = self.scrollView.contentSize
        let viewSize = self.bounds.size
        let zoomScale = viewSize.width/contentSize.width
        self.scrollView.minimumZoomScale = zoomScale
        self.scrollView.maximumZoomScale = zoomScale
        self.scrollView.zoomScale = zoomScale
    }
}