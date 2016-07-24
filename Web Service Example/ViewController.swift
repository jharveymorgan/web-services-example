//
//  ViewController.swift
//  Web Service Example
//
//  Created by Jordan Harvey-Morgan on 7/14/16.
//  Copyright © 2016 Jordan Harvey-Morgan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //forecast label
    @IBOutlet weak var forecastLabel: LTMorphingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // use AFNetworking to use weather service api
        let manager = AFHTTPSessionManager()
        // get data from OpenWeatherMap using the GET method
        manager.GET("http://api.openweathermap.org/data/2.5/forecast/daily?q=Detroit&mode=json&units=metric&cnt=1&appid=73aee2a1963ab8d441b6fd5171d69850",
                    parameters: nil,
                    progress: nil,
                    success: { (operation: NSURLSessionDataTask,responseObject: AnyObject?) in
                        if let responseObject = responseObject {
                            print("Response: " + responseObject.description)
                            
                            self.forecastLabel.morphingEffect = .Evaporate
                            
                            // swiftyJSON way to access weather info from api
                            let json = JSON(responseObject)
                            if let forecast = json["list"][0]["weather"][0]["description"].string {
                                self.forecastLabel.text = forecast
                                
                                // change backround based on temperature
                                if let forecastTemp = json["list"][0]["temp"]["day"].float {
                                    if forecastTemp >= 29 {
                                        // red for hot
                                        self.view.backgroundColor = UIColor.init(red: 235/255, green: 53/255, blue: 61/255, alpha: 1)
                                    } else if forecastTemp <= 0 {
                                        // blue for cold
                                        self.view.backgroundColor = UIColor.init(red: 72/255, green: 192/255, blue: 235/255, alpha: 1)
                                    }
                                }
                            }
                        }
            },
                    failure: { (operation: NSURLSessionDataTask?,error: NSError) in
                        print("Error: " + error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

