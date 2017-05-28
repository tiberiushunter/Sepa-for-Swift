//
//  WeatherCurrentlyViewController.swift
//  SEPA
//
//  Created by Welek Samuel on 19/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit
import MapKit

class WeatherCurrentlyViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var coords = CLLocationCoordinate2D(latitude: 53.4846, longitude: -2.2708)
    
    //var refreshControl: UIRefreshControl!

    var summary = ""
    var currentTemperature = 0.00
    var feelLikeTemperaure = 0.00
    var windDirection = 0.00
    var windSpeed = 0.00
    var chanceOfRain = 0.00
    var rainIntensity = 0.00
    var nearestStormDistance = 0.00
    var nearestStormDirection = 0.00
    var imageIcon = WeatherIcon.nothing
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblLocation: UILabel!

    @IBOutlet weak var lblSummary: UILabel!
    
    @IBOutlet weak var lblCurrentTemp: UILabel!
    
    @IBOutlet weak var lblFeelLikeTemp: UILabel!
    
    @IBOutlet weak var lblWindDirection: UILabel!
    
    @IBOutlet weak var lblWindSpeed: UILabel!
    
    @IBOutlet weak var lblChanceOfRain: UILabel!
    
    @IBOutlet weak var lblRainIntensity: UILabel!
    
    @IBOutlet weak var lblNearestStormDistance: UILabel!
    
    @IBOutlet weak var lblNearestStormDirection: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   //     let path: String = NSBundle.mainBundle().pathForResource("day", ofType: "svg")!
        
   //     let url: NSURL = NSURL.fileURLWithPath(path)  //Creating a URL which points towards our path
        
        //Creating a page request which will load our URL (Which points to our path)
      //  let request: NSURLRequest = NSURLRequest(URL: url)
        
        
        //webView.scalesPageToFit = false
        
        
        //     let contentSize = webView.scrollView.contentSize;
        //    let webViewSize = webView.bounds.size;
        //    let scaleFactor = webViewSize.width / contentSize.width;
        
        //   webView.scrollView.minimumZoomScale = scaleFactor;
        //   webView.scrollView.maximumZoomScale = scaleFactor;
        //   webView.scrollView.zoomScale = scaleFactor;
        
        
        
      //  webView.loadRequest(request)  //Telling our webView to load our above request
        
        
     //   webView.resizeWebContent()
        

        
        setTimeLabel()
        setLocationLabel()
        
        
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
    
    func setTimeLabel(){
        let currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let convertedDate = dateFormatter.stringFromDate(currentDate)
        
        self.lblTime.text = "Last Updated: " + convertedDate
    }
    
    func setLocationLabel(){
        self.lblLocation.text = "Current Location"
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
                        print(currently)
                        if let currTemp = currently["temperature"] as? Double{
                            self.currentTemperature = currTemp
                        }
                        if let feelLikeTemp = currently["apparentTemperature"] as? Double {
                            self.feelLikeTemperaure = feelLikeTemp
                        }
                        if let sum = currently["summary"] as? String {
                            self.summary = sum
                        }
                        if let windDir = currently["windBearing"] as? Double {
                            self.windDirection = windDir
                        }
                        if let windSpe = currently["windSpeed"] as? Double {
                            self.windSpeed = windSpe
                        }
                        if let chanceOfRain = currently["precipProbability"] as? Double {
                            self.chanceOfRain = chanceOfRain
                        }
                        if let rainInt = currently["precipIntensity"] as? Double {
                            self.rainIntensity = rainInt
                        }
                        if let nearStormDist = currently["nearestStormDistance"] as? Double {
                            self.nearestStormDistance = nearStormDist
                        }
                        if let nearStormDir = currently["nearestStormBearing"] as? Double {
                            self.nearestStormDirection = nearStormDir
                        }
                        if let imageIcon = currently["icon"] as? String {
                            switch(imageIcon){
                                case "clear-day": self.imageIcon = WeatherIcon.clearDay
                                case "clear-night": self.imageIcon = WeatherIcon.clearNight
                                case "rain": self.imageIcon = WeatherIcon.rain
                                case "snow": self.imageIcon = WeatherIcon.snow
                                case "sleet": self.imageIcon = WeatherIcon.snow
                                case "wind": self.imageIcon = WeatherIcon.wind
                                case "fog": self.imageIcon = WeatherIcon.fog
                                case "cloudy": self.imageIcon = WeatherIcon.cloudy
                                case "partly-cloudy-day": self.imageIcon = WeatherIcon.partlyCloudyDay
                                case "partly-cloudy-night": self.imageIcon = WeatherIcon.partlyCloudyNight
                                case "hail": self.imageIcon = WeatherIcon.rain
                                case "thunderstorm": self.imageIcon = WeatherIcon.thunderstorm
                                case "tornado": self.imageIcon = WeatherIcon.tornado
                                default: self.imageIcon = WeatherIcon.nothing
                            }
                        }
                        dispatch_async(dispatch_get_main_queue()) {

                            self.lblSummary.text = self.summary
                            self.lblCurrentTemp.text = String(format: "%.2f", self.convertToCelsius(self.currentTemperature)) + "°C"
                            self.lblFeelLikeTemp.text = String(format: "%.2f", self.convertToCelsius(self.feelLikeTemperaure)) + "°C"
                            self.lblWindDirection.text = String(format: "%.2f", self.windDirection)
                            self.lblWindSpeed.text = String(format: "%.2f", self.windSpeed)
                            self.lblChanceOfRain.text = String(format: "%.2f", self.chanceOfRain)
                            self.lblRainIntensity.text = String(format: "%.2f", self.rainIntensity)
                            self.lblNearestStormDistance.text = String(format: "%.2f", self.nearestStormDistance)
                            self.lblNearestStormDirection.text = String(format: "%.2f", self.nearestStormDirection)
                            //self.weatherImage.image = UIImage(named: String(self.imageIcon))
                            self.weatherImage.image = UIImage(named:self.imageIcon.rawValue)
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