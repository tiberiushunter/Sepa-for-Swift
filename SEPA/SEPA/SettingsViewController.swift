//
//  SettingsViewController.swift
//  SEPA
//
//  Created by Welek Samuel on 19/05/2017.
//  Copyright © 2017 Welek Samuel. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    /*
 
 
 
 
 //
 
 //    let bbcNewsSource = NSUserDefaults.standardUserDefaults().objectForKey("newsSource_bbcNews") as! Bool
 
 //    if(bbcNewsSource == true){
 //    newsSources.append("BBC News")
 //   }
 
 NSUserDefaults.standardUserDefaults().setObject(Bool(true), forKey:"newsSource_bbc-news")
 
 
 
 */

    let settingList = ["abc News",
                     "Al Jalzeera",
                     "Ars Technica",
                     "Associated Press",
                     "BBC News",
                     "BBC Sports",
                     "Bild",
                     "Bloomberg",
                     "Breitbart",
                     "Business Insider",
                     "Business Insider UK",
                     "BuzzFeed",
                     "CNBC",
                     "CNN",
                     "Daily Mail",
                     "Der Tagesspiegel",
                     "Die Zeit",
                     "Engadget",
                     "Entertainment Weekly",
                     "ESPN",
                     "ESPN Cric Info",
                     "Financial Times",
                     "Football Italia",
                     "Fortune",
                     "Four Four Two",
                     "Fox Sports",
                     "Google News",
                     "Gruenderszene",
                     "Hacker News",
                     "Handelsblatt",
                     "IGN",
                     "Independent",
                     "Mashable",
                     "Metro",
                     "Mirror",
                     "MTV News",
                     "MTV News UK",
                     "National Geographic",
                     "New Scientist",
                     "Newsweek",
                     "New York Magazine",
                     "NFL News",
                     "Online Focus",
                     "Polygon",
                     "Recode",
                     "Reddit",
                     "Reuters",
                     "Spiegel Online",
                     "t3N",
                     "Talk Sport",
                     "Tech Crunch",
                     "Tech Radar",
                     "The Economist",
                     "The Guardian",
                     "The Hindu",
                     "The Huffington Post",
                     "The Lad Bible",
                     "The New York Times",
                     "The Next Web",
                     "The Sport Bible",
                     "The Telegraph",
                     "The Times Of India",
                     "The Verge",
                     "The Wall Street Journal",
                     "The Washington Post",
                     "Time",
                     "USA Today",
                     "Wired.de",
                     "Wirtschafts Woche"]
    
    let switchList = ["abcNews",
                     "al-jalzeera",
                     "arsTechnica",
                     "associatedPress",
                     "bbcNews",
                     "bbcSports",
                     "bild",
                     "bloomberg",
                     "breitbart",
                     "businessInsider",
                     "businessInsiderUK",
                     "buzzFeed",
                     "cnbc",
                     "cnn",
                     "dailyMail",
                     "derTagesspiegel",
                     "dieZeit",
                     "engadget",
                     "entertainmentWeekly",
                     "espn",
                     "espnCricInfo",
                     "financialTimes",
                     "footballItalia",
                     "fortune",
                     "fourFourTwo",
                     "foxSports",
                     "googleNews",
                     "gruenderszene",
                     "hackerNews",
                     "handelsblatt",
                     "ign",
                     "independent",
                     "mashable",
                     "metro",
                     "mirror",
                     "mtvNews",
                     "mtvNewsUK",
                     "nationalGeographic",
                     "newScientist",
                     "newsweek",
                     "newYorkMagazine",
                     "nflNews",
                     "onlineFocus",
                     "polygon",
                     "recode",
                     "reddit",
                     "reuters",
                     "spiegelOnline",
                     "t3N",
                     "talkSport",
                     "techCrunch",
                     "techRadar",
                     "theEconomist",
                     "theGuardian",
                     "theHindu",
                     "theHuffingtonPost",
                     "theLadBible",
                     "theNewYorkTimes",
                     "theNextWeb",
                     "theSportBible",
                     "theTelegraph",
                     "theTimesOfIndia",
                     "theVerge",
                     "theWallStreetJournal",
                     "theWashingtonPost",
                     "time",
                     "usaToday",
                     "wired.de",
                     "wirtschaftsWoche"]
    
    
    let settingSectionList = ["My News Sources"]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var passedString = "blank"
    let reuseIdentifier = "tableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
 
        tableView.dataSource = self
        tableView.delegate = self
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SettingsTableViewCell = (tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as? SettingsTableViewCell)!
        
        cell.lblSetting.text = settingList[indexPath.row]
        cell.setting = switchList[indexPath.row]
        cell.newsLogo.image = UIImage(named: switchList[indexPath.row])
        
        return cell
    }
    
   // func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
   //     return
  //  }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return settingSectionList.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
