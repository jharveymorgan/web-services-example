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
    @IBOutlet weak var forecastLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // use AFNetworking to use weather service api
        let manager = AFHTTPSessionManager()
        // get data from OpenWeatherMap using the GET method
        manager.GET("http://api.openweathermap.org/data/2.5/forecast/daily?q=London&mode=json&units=metric&cnt=1&appid=73aee2a1963ab8d441b6fd5171d69850",
                    parameters: nil,
                    progress: nil,
                    success: { (operation: NSURLSessionDataTask,responseObject: AnyObject?) in
                        if let responseObject = responseObject {
                            print("Response: " + responseObject.description)
                            
                            // get data for forecast from json
                            if let listOfDays = responseObject["list"] as? [AnyObject] {
                                if let tomorrow = listOfDays[0] as? [String:AnyObject] {
                                    if let tomorrowsWeather = tomorrow["weather"] as? [AnyObject] {
                                        if let firstWeatherOfDay = tomorrowsWeather[0] as? [String:AnyObject] {
                                            if let forecast = firstWeatherOfDay["description"] as? String? {
                                                self.forecastLabel.text = forecast
                                            }
                                        }
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

