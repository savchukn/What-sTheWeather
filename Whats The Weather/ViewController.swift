//
//  ViewController.swift
//  Whats The Weather
//
//  Created by Nikita Savchuk on 13.11.15.
//  Copyright © 2015 1011. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var cityTextField: UITextField!
    
    @IBAction func button(sender: AnyObject) {
        
        //NSAppTransportSecurity -> NSAllowArbitraryLoads -> Yes
        let url = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                let websiteArray = webContent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if websiteArray?.count > 1 {
                    
                    let weatherArray = websiteArray![1].componentsSeparatedByString("</span>")
                    
                    if weatherArray.count > 1 {
                        
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg", withString: "º")
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                            self.resultLabel.text = "3 Day Weather Forecast Summary: \n" + weatherSummary
                            
                        })
                        
                    }
                    
                }
                
            }
            
        }
        
        task.resume()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

